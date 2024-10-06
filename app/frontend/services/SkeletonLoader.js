export class SkeletonLoader {
  constructor(config) {
    this.config = {
      containerId: 'skeletonLoader',
      contentId: 'actualContent',
      itemCount: 10,
      itemTemplate: this.defaultItemTemplate,
      ...config
    }
  }

  defaultItemTemplate() {
    return `
      <div class="w-[122px] sm:w-[140px] h-[255px] overflow-hidden rounded-lg border border-tmdbLightGray mb-2.5 pb-2.5 shadow-light animate-pulse">
        <div class="mt-2.5 mx-2.5 text-left">
          <div class="h-5 bg-gray-200 rounded w-3/4 mb-1"></div>
          <div class="h-4 bg-gray-200 rounded w-1/2"></div>
        </div>
      </div>
    `
  }

  createSkeletonItem() {
    const li = document.createElement('li')
    li.innerHTML = this.config.itemTemplate()
    return li
  }

  createSkeletonItems() {
    const skeletonLoader = document.getElementById(this.config.containerId)
    if (skeletonLoader) {
      for (let i = 0; i < this.config.itemCount; i++) {
        skeletonLoader.appendChild(this.createSkeletonItem())
      }
    }
  }

  handleContentLoading() {
    window.addEventListener('load', () => {
      const skeletonLoader = document.getElementById(this.config.containerId)
      const actualContent = document.getElementById(this.config.contentId)
      if (skeletonLoader && actualContent) {
        skeletonLoader.style.display = 'none'
        actualContent.style.display = 'flex'
      }
    })
  }

  init() {
    this.createSkeletonItems()
    this.handleContentLoading()
  }
}