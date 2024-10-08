import {SkeletonLoader} from './SkeletonLoader'

const castTemplate = () => `
      <div class="w-[122px] sm:w-[140px] h-[255px] overflow-hidden rounded-lg border border-tmdbLightGray mb-2.5 pb-2.5 shadow-light">
        <div class="h-[175px] bg-gray-200 flex items-center justify-center relative">
          <svg class="w-3/4 relative z-10">
            <use xlink:href="#user-skeleton"></use>
          </svg>
          <div class="shimmer-wrapper">
            <div class="shimmer"></div>
          </div>
        </div>
        <div class="mt-2.5 mx-2.5 text-left">
          <div class="h-5 bg-gray-200 rounded w-3/4 mb-1 relative">
            <div class="shimmer-wrapper">
              <div class="shimmer"></div>
            </div>
          </div>
          <div class="h-4 bg-gray-200 rounded w-1/2 relative">
            <div class="shimmer-wrapper">
              <div class="shimmer"></div>
            </div>
          </div>
        </div>
      </div>
`

const actionsPanelTemplate = () => `
  <div class="flex justify-between items-center opacity-20 space-x-2 p-2">
    <div class="w-16 h-16 bg-gray-200 rounded-full relative overflow-hidden">
      <div class="shimmer-wrapper">
        <div class="shimmer"></div>
      </div>
    </div>
    <div>
    <div class="w-5 h-2 mb-2 bg-gray-200 rounded relative overflow-hidden">
      <div class="shimmer-wrapper">
        <div class="shimmer"></div>
      </div>
    </div>
    <div class="w-7 h-2 bg-gray-200 rounded relative overflow-hidden">
      <div class="shimmer-wrapper">
        <div class="shimmer"></div>
      </div>
    </div>
</div>
    <div class="w-10 h-10 bg-gray-200 rounded-full relative overflow-hidden">
      <div class="shimmer-wrapper">
        <div class="shimmer"></div>
      </div>
    </div>
    <div class="w-10 h-10 bg-gray-200 rounded-full relative overflow-hidden">
      <div class="shimmer-wrapper">
        <div class="shimmer"></div>
      </div>
    </div>
    <div class="w-10 h-10 bg-gray-200 rounded-full relative overflow-hidden">
      <div class="shimmer-wrapper">
        <div class="shimmer"></div>
      </div>
    </div>
    <div class="w-24 h-8 bg-gray-200 rounded relative overflow-hidden">
      <div class="shimmer-wrapper">
        <div class="shimmer"></div>
      </div>
    </div>
  </div>
`

export function initializeSkeletons() {
  const castLoader = new SkeletonLoader({
    skeletonId: 'skeleton-cast-loader',
    actualContentId: 'actual-cast-content',
    itemTemplate: castTemplate,
    itemCount: 10,
  })
  const actionsPanelLoader = new SkeletonLoader({
    skeletonId: 'skeleton-actions-panel-loader',
    actualContentId: 'actions-panel',
    itemTemplate: actionsPanelTemplate,
    itemCount: 1,
  })
  castLoader.init()
  actionsPanelLoader.init()
}