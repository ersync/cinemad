export function initializeDOM() {
  // Prevent space input in the username field
  const usernameInput = document.getElementById('user_username')
  if (usernameInput) {
    usernameInput.addEventListener('keypress', function (e) {
      if (e.which === 32) {
        e.preventDefault()
      }
    })
  }


}