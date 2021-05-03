import {Controller} from 'stimulus'

export default class extends Controller {
    static targets = ["slides", "slide", "previous", "next"]

    // INITIALIZER
    connect() {
        this.currentIndex = 1
        this.totalIndexes = this.slidesCount
    }

    // BEHAVIOR

    prev() {
        if (this.hasStarted()) {
            this.currentIndex = (this.currentIndex - 1)
            this.slidesTarget.scrollLeft -= this.slideTarget.offsetWidth
        }
        this.updateSteppersVisibility()
    }

    next() {
        if (!this.hasEnded()) {
            this.currentIndex = (this.currentIndex + 1)
            this.slidesTarget.scrollLeft += this.slideTarget.offsetWidth
        }
        this.updateSteppersVisibility()
    }

    hasStarted() {
        return this.currentIndex > 1
    }

    hasEnded() {
        return this.currentIndex === this.slidesCount
    }

    updateSteppersVisibility() {
        this.toggle(this.nextTarget, this.hasEnded())
        this.toggle(this.previousTarget, !this.hasStarted())
    }

    toggle(stepper, force) {
        stepper.classList.toggle("hidden", force)
    }

    // GETTERS & SETTERS

    get currentIndex() {
        return Number(this.element.dataset.currentIndex)
    }

    get slideIndex() {
        return Number(this.element.dataset.slideIndex)
    }

    get slidesCount() {
        return this.slideTargets.length
    }

    set currentIndex(value) {
        this.element.dataset.currentIndex = value
    }

    set totalIndexes(value) {
        this.element.dataset.totalIndexes = value
    }
}