import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "item", "count", "empty", "categoryPill"]

  connect() {
    this.selectedCategory = "all"
  }

  filter() {
    const query = this.hasInputTarget ? this.inputTarget.value.toLowerCase().trim() : ""
    let visibleCount = 0

    this.itemTargets.forEach((item) => {
      const title = item.dataset.title ? item.dataset.title.toLowerCase() : ""
      const excerpt = item.dataset.excerpt ? item.dataset.excerpt.toLowerCase() : ""
      const category = item.dataset.category ? item.dataset.category.toLowerCase() : ""

      const matchesSearch = query === "" || title.includes(query) || excerpt.includes(query)
      const matchesCategory = this.selectedCategory === "all" || category === this.selectedCategory

      if (matchesSearch && matchesCategory) {
        item.style.display = ""
        visibleCount++
      } else {
        item.style.display = "none"
      }
    })

    if (this.hasCountTarget) {
      this.countTarget.textContent = `${visibleCount} ${visibleCount === 1 ? "essay" : "essays"}`
    }

    if (this.hasEmptyTarget) {
      if (visibleCount === 0) {
        this.emptyTarget.style.display = "block"
      } else {
        this.emptyTarget.style.display = "none"
      }
    }
  }

  selectCategory(event) {
    event.preventDefault()
    const clickedPill = event.currentTarget
    this.selectedCategory = clickedPill.dataset.category || "all"

    if (this.hasCategoryPillTarget) {
      this.categoryPillTargets.forEach((pill) => {
        pill.classList.toggle("is-active", pill === clickedPill)
      })
    }

    this.filter()
  }

  clear() {
    if (this.hasInputTarget) {
      this.inputTarget.value = ""
    }
    this.selectedCategory = "all"
    if (this.hasCategoryPillTarget) {
      this.categoryPillTargets.forEach((pill) => {
        pill.classList.toggle("is-active", pill.dataset.category === "all")
      })
    }
    this.filter()
  }
}
