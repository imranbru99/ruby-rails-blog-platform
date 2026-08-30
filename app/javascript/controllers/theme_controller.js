import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "icon"]

  connect() {
    this.initTheme()
  }

  initTheme() {
    const savedTheme = localStorage.getItem("meridian_theme")
    if (savedTheme) {
      this.applyTheme(savedTheme)
    } else if (window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches) {
      this.applyTheme("dark")
    } else {
      this.applyTheme("light")
    }
  }

  toggle() {
    const currentTheme = document.documentElement.getAttribute("data-theme") || "light"
    const nextTheme = currentTheme === "dark" ? "light" : "dark"
    this.applyTheme(nextTheme)
    localStorage.setItem("meridian_theme", nextTheme)
  }

  applyTheme(theme) {
    document.documentElement.setAttribute("data-theme", theme)
    if (this.hasIconTarget) {
      this.iconTarget.textContent = theme === "dark" ? "☀️" : "🌙"
    }
    if (this.hasButtonTarget) {
      this.buttonTarget.setAttribute("aria-label", `Switch to ${theme === "dark" ? "light" : "dark"} mode`)
      this.buttonTarget.setAttribute("title", `Switch to ${theme === "dark" ? "light" : "dark"} mode`)
    }
  }
}
