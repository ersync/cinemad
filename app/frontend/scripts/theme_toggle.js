document.addEventListener('DOMContentLoaded', function() {
  const themeToggleBtn = document.getElementById('theme-toggle');
  const mobileThemeToggleBtn = document.getElementById('mobile-theme-toggle');
  const mobileThemeItem = document.getElementById('mobile-theme-item');
  const body = document.body;
  const html = document.documentElement;
  
  const savedTheme = localStorage.getItem('theme');
  
  if (savedTheme === 'light') {
    body.classList.remove('dark');
    html.classList.remove('dark');
  } else {
    localStorage.setItem('theme', 'dark');
  }
  
  function toggleTheme(e) {
    e.stopPropagation();
    
    if (body.classList.contains('dark')) {
      body.classList.remove('dark');
      html.classList.remove('dark');
      localStorage.setItem('theme', 'light');
    } else {
      body.classList.add('dark');
      html.classList.add('dark');
      localStorage.setItem('theme', 'dark');
    }
    
    body.classList.add('theme-transition');
    setTimeout(() => {
      body.classList.remove('theme-transition');
    }, 700);
  }
    
  if (themeToggleBtn) {
    themeToggleBtn.addEventListener('click', toggleTheme);
  }
    
  if (mobileThemeToggleBtn) {
    mobileThemeToggleBtn.addEventListener('click', function(e) {
      toggleTheme(e);
    });
    
    const svgElements = mobileThemeToggleBtn.querySelectorAll('svg');
    svgElements.forEach(svg => {
      svg.addEventListener('click', function(e) {
        e.preventDefault();
        toggleTheme(e);
      });
    });
  }
    
  if (mobileThemeItem) {
    mobileThemeItem.addEventListener('click', toggleTheme);
  }
});
