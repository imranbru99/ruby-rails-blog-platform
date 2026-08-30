admin = AdminUser.find_or_initialize_by(email: "admin@meridian.test")
admin.password = "admin12345"
admin.save!

ruby = Category.find_or_initialize_by(slug: "ruby")
ruby.update!(name: "Ruby", description: "Language, runtime, and the Rails stack.")

craft = Category.find_or_initialize_by(slug: "craft")
craft.update!(name: "Craft", description: "Process, taste, and how work gets made.")

design = Category.find_or_initialize_by(slug: "design")
design.update!(name: "Design", description: "Interface, type, and the feel of a page.")

essays = Category.find_or_initialize_by(slug: "essays")
essays.update!(name: "Essays", description: "Longer pieces that do not fit a tighter shelf.")

posts = [
  {
    slug: "why-ruby-still-feels-like-home",
    title: "Why Ruby still feels like home",
    category: ruby,
    featured: true,
    excerpt: "Twenty years on, the language that optimized for programmer happiness still rewards careful readers.",
    body: <<~HTML
      <p>Ruby is not the fastest language in the room. That was never the point. It is a language that treats the person writing it as the primary audience, and that decision still shows up in the smallest methods.</p>
      <p>A blog is a good example. Models stay close to the nouns they describe. Routes stay readable. A slug is just a string until the moment it becomes an address on the public web.</p>
      <h2>Clarity over ceremony</h2>
      <p>When a post is published, it should live at a URL a person can remember. <code>/why-ruby-still-feels-like-home</code> is enough. No extra prefix, no numeric id leaking into the address bar.</p>
      <blockquote>The job of a framework is to disappear once the writing is on the page.</blockquote>
      <p>Rails does that well when you let it. Categories file the archive. The admin panel stays behind a login. The public site is just essays, type, and space to breathe.</p>
    HTML
  },
  {
    slug: "a-small-theory-of-slugs",
    title: "A small theory of slugs",
    category: craft,
    excerpt: "A slug is not decoration. It is the public name of a piece of writing.",
    body: <<~HTML
      <p>Titles change. Ids are accidental. A slug is the name you are willing to keep.</p>
      <p>Good slugs are short, lowercase, and stable. They avoid dates unless the date is the point. They do not encode the CMS. They read like a path a person might say out loud.</p>
      <h2>Category slugs</h2>
      <p>A category deserves the same care. <code>/category/ruby</code> should mean one thing for years. If you rename the display title, keep the slug unless you are prepared to redirect the old one.</p>
    HTML
  },
  {
    slug: "designing-a-reading-room",
    title: "Designing a reading room",
    category: design,
    excerpt: "A journal should feel like paper under a lamp, not a dashboard pretending to be a magazine.",
    body: <<~HTML
      <p>Most blogs fail in the same place: they dress the chrome and starve the type. The measure of a reading site is whether someone can finish a long piece without noticing the theme.</p>
      <p>That means a quiet header, a line length the eye can hold, and a home page that features one essay instead of twelve identical cards shouting at once.</p>
      <h2>Ink and paper</h2>
      <p>Warm paper, dark ink, one accent color. Serif for titles, a humanist sans for the rest. If the design is working, you forget it was designed.</p>
    HTML
  },
  {
    slug: "the-admin-should-be-boring",
    title: "The admin should be boring",
    category: craft,
    excerpt: "Editorial tools earn trust by being predictable, not clever.",
    body: <<~HTML
      <p>A writer should be able to file a draft, set a category, choose a slug, and publish. Anything else is secondary.</p>
      <p>The Meridian admin panel is intentionally plain: a sidebar, a table, a form. Publish is a checkbox. Featured is a checkbox. Delete asks once.</p>
      <p>Boredom in the back office is a feature. The public page is where the work should feel alive.</p>
    HTML
  },
  {
    slug: "rails-for-a-personal-journal",
    title: "Rails for a personal journal",
    category: ruby,
    excerpt: "You do not need a headless stack to publish essays. You need models, routes, and taste.",
    body: <<~HTML
      <p>A personal journal has a small surface area. Posts belong to categories. An editor signs in. The rest is presentation.</p>
      <p>Rails still maps that world without translation. Active Record holds the archive. Action Text holds the body. A single catch-all route turns a slug into a page.</p>
      <h2>What to skip</h2>
      <p>Skip the extra microservices. Skip the client-side router. Keep the HTML on the server and let Turbo handle the small interactions. The result is a site you can understand a year later.</p>
    HTML
  },
  {
    slug: "on-keeping-an-archive",
    title: "On keeping an archive",
    category: essays,
    excerpt: "An archive is a promise that old work will still be findable when you need it.",
    body: <<~HTML
      <p>The first post is easy. The fiftieth is where the structure either holds or collapses. Categories exist so a reader can wander without a search box. Slugs exist so a link from five years ago still resolves.</p>
      <p>Publish less if you must. Just do not break the addresses of what you already said.</p>
    HTML
  }
]

posts.each do |attrs|
  post = Post.find_or_initialize_by(slug: attrs[:slug])
  post.assign_attributes(
    title: attrs[:title],
    excerpt: attrs[:excerpt],
    category: attrs[:category],
    featured: attrs[:featured] || false,
    published: true,
    published_at: post.published_at || Time.current,
    body: attrs[:body]
  )
  post.save!
end

puts "Seeded #{Category.count} categories, #{Post.count} posts, and admin #{admin.email}."
