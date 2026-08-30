import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bar", "backToTop"]

  connect() {
    this.updateProgress = this.updateProgress.bind(this)
    window.addEventListener("scroll", this.updateProgress, { passive: true })
    this.updateProgress()
  }

  disconnect() {
    window.removeEventListener("scroll", this.updateProgress)
  }

  updateProgress() {
    const docElement = document.documentElement
    const body = document.body
    const scrollTop = docElement.scrollTop || body.scrollTop
    const scrollHeight = (docElement.scrollHeight || body.scrollHeight) - docElement.clientHeight

    const progress = scrollHeight > 0 ? (scrollTop / scrollHeight) * 100 : 0
    if (this.hasBarTarget) {
      this.barTarget.style.width = `${Math.min(100, Math.max(0, progress))}%`
    }

    if (this.hasBackToTopTarget) {
      if (scrollTop > 400) {
        this.backToTopTarget.classList.add("is-visible")
      } else {
        this.backToTopTarget.classList.remove("is-visible")
      }
    }
  }

  scrollToTop() {
    window.scrollTo({
      top: 0,
      behavior: "smooth"
    })
  }
}
