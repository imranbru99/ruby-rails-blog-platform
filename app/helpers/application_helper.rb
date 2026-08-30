module ApplicationHelper
  SITE_NAME = "Meridian"
  SITE_TAGLINE = "Essays on software, craft, and making things that last."

  def site_name
    SITE_NAME
  end

  def site_tagline
    SITE_TAGLINE
  end

  def page_title(title = nil)
    [ title, SITE_NAME ].compact.join(" · ")
  end

  def published_on(post)
    date = post.published_at || post.created_at
    date.strftime("%B %-d, %Y")
  end

  def nav_link_to(label, path, **)
    active = current_page?(path)
    classes = [ "nav-link", ("is-active" if active) ].compact.join(" ")
    link_to label, path, class: classes, **
  end

  def admin_nav_class(path)
    if path == admin_root_path
      request.path == path ? "is-active" : nil
    else
      request.path.start_with?(path) ? "is-active" : nil
    end
  end
end
