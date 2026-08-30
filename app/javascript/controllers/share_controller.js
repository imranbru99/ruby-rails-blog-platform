import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "label", "toast"]

  async copy(event) {
    event.preventDefault()
    const url = this.buttonTarget.dataset.url || window.location.href

    try {
      if (navigator.clipboard && window.isSecureContext) {
        await navigator.clipboard.writeText(url)
      } else {
        const textArea = document.createElement("textarea")
        textArea.value = url
        textArea.style.position = "fixed"
        textArea.style.opacity = "0"
        document.body.appendChild(textArea)
        textArea.focus()
        textArea.select()
        document.execCommand("copy")
        document.body.removeChild(textArea)
      }
      this.showFeedback()
    } catch (err) {
      console.error("Failed to copy URL: ", err)
    }
  }

  async share(event) {
    event.preventDefault()
    const title = this.buttonTarget.dataset.title || document.title
    const url = this.buttonTarget.dataset.url || window.location.href

    if (navigator.share) {
      try {
        await navigator.share({ title, url })
      } catch (err) {
        if (err.name !== "AbortError") {
          this.copy(event)
        }
      }
    } else {
      this.copy(event)
    }
  }

  showFeedback() {
    if (this.hasLabelTarget) {
      const original = this.labelTarget.textContent
      this.labelTarget.textContent = "Copied! ✓"
      setTimeout(() => {
        this.labelTarget.textContent = original
      }, 2200)
    }

    const toast = document.getElementById("toast-notification")
    if (toast) {
      toast.textContent = "Link copied to clipboard!"
      toast.classList.add("is-active")
      setTimeout(() => {
        toast.classList.remove("is-active")
      }, 2500)
    }
  }
}
