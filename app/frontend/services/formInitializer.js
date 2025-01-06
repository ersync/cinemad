// app/frontend/services/formInitializer.js
export function initializeForms() {
  initializeWatchlistForms()
  initializeFavoriteForms()
}

function initializeWatchlistForms() {
  const forms = document.querySelectorAll('.remove-watchlist-form')

  forms.forEach(form => {
    form.addEventListener('submit', handleWatchlistSubmit)
  })
}

function initializeFavoriteForms() {
  const forms = document.querySelectorAll('.favorite-form')

  forms.forEach(form => {
    const movieId = form.querySelector('.favorite-btn').dataset.movieId
    const favoriteIcon = form.querySelector('.favorite-icon')

    // Check initial state
    checkFavoriteStatus(movieId, favoriteIcon)

    // Handle toggle
    form.addEventListener('submit', (e) => handleFavoriteSubmit(e, favoriteIcon))
  })
}

async function handleWatchlistSubmit(e) {
  e.preventDefault()

  try {
    const response = await fetch(this.action, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
      }
    })

    if (response.ok) {
      window.location.reload()
    }
  } catch (error) {
    console.error('Error removing from watchlist:', error)
  }
}

async function checkFavoriteStatus(movieId, favoriteIcon) {
  try {
    const response = await fetch(`/movies/${movieId}/favorite`, {
      headers: { 'Accept': 'application/json' }
    })
    const data = await response.json()

    if (data.isFavorite) {
      favoriteIcon.classList.add('bg-red-500', 'text-white', 'border-none')
    }
  } catch (error) {
    console.error('Error checking favorite status:', error)
  }
}

async function handleFavoriteSubmit(e, favoriteIcon) {
  e.preventDefault()
  const form = e.target
  const isFavorited = favoriteIcon.classList.contains('bg-red-500')

  try {
    const response = await fetch(form.action, {
      method: isFavorited ? 'DELETE' : 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
        'Accept': 'application/json'
      }
    })

    const data = await response.json()
    if (data.success) {
      toggleFavoriteIcon(favoriteIcon, isFavorited)
    }
  } catch (error) {
    console.error('Error toggling favorite:', error)
  }
}

function toggleFavoriteIcon(icon, isFavorited) {
  if (isFavorited) {
    icon.classList.remove('bg-red-500', 'text-white', 'border-none')
  } else {
    icon.classList.add('bg-red-500', 'text-white', 'border-none')
  }
}