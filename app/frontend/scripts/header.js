document.addEventListener('DOMContentLoaded', function() {
  // Mobile menu elements
  const menuButton = document.getElementById('menu-button');
  const mobileMenu = document.getElementById('mobile-menu');
  const mobileMenuOverlay = document.getElementById('mobile-menu-overlay');
  
  // Profile elements
  const profileMenu = document.getElementById('mobile-profile-menu');
  const profileMenuOverlay = document.getElementById('profile-menu-overlay');
  const profileButton = document.getElementById('profile-menu-button');
  const menuItems = document.querySelectorAll('.menu-item');
  
  // User dropdown elements
  const userDropdownButton = document.getElementById('userDropdownButton');
  const userDropdown = document.getElementById('userDropdown');
  const userDropdownContainer = document.getElementById('userDropdownContainer');
  
  // Search elements
  const searchContainer = document.getElementById('search-container');
  const searchIcon = document.getElementById('search-icon');
  const searchInput = document.getElementById('search-input');
  const mainHeader = document.getElementById('main-header');
  
  // ===== MOBILE MENU FUNCTIONS =====
  
  function updateMenuIcon() {
    if (!menuButton || !mobileMenu) {
      return;
    }

    const isMenuOpen = !mobileMenu.classList.contains('-translate-x-full');

    if (isMenuOpen) {
      menuButton.classList.add('open');
    } else {
      menuButton.classList.remove('open');
    }
  }

  function toggleMenu() {
    if (!mobileMenu) {
      return;
    }

    mobileMenu.classList.toggle('-translate-x-full');

    if (mobileMenuOverlay) {
      if (mobileMenu.classList.contains('-translate-x-full')) {
        mobileMenuOverlay.classList.add('opacity-0', 'pointer-events-none');
        mobileMenuOverlay.classList.remove('active');
        document.body.style.overflow = '';
      } else {
        mobileMenuOverlay.classList.remove('opacity-0', 'pointer-events-none');
        mobileMenuOverlay.classList.add('active');
        document.body.style.overflow = 'hidden';

      }
    }

    updateMenuIcon();
    
    if (isSearchExpanded) {
      collapseSearch();
    }
  }

  function closeMenu() {
    if (!mobileMenu) return;

    mobileMenu.classList.add('-translate-x-full');
    
    if (mobileMenuOverlay) {
      mobileMenuOverlay.classList.add('opacity-0', 'pointer-events-none');
      mobileMenuOverlay.classList.remove('active');
    }
    document.body.style.overflow = '';

    updateMenuIcon();
  }

  function toggleProfileMenu(event) {
    if (event) {
      event.stopPropagation();
    }

    if (!profileMenu || !profileMenuOverlay) return;

    const isMenuOpen = !profileMenu.classList.contains('translate-y-full');

    if (isMenuOpen) {
      profileMenu.classList.add('translate-y-full');
      profileMenuOverlay.classList.add('opacity-0', 'pointer-events-none');
    } else {
      profileMenu.classList.remove('translate-y-full');
      profileMenuOverlay.classList.remove('opacity-0', 'pointer-events-none');
    }
  }

  function handleProfileMenuClick(event) {
    if (!profileMenu) return;

    if (profileButton && profileButton.contains(event.target)) {
      return;
    }

    const isClickInsideMenu = profileMenu.contains(event.target);
    const isMenuOpen = !profileMenu.classList.contains('translate-y-full');

    if (!isClickInsideMenu && isMenuOpen) {
      toggleProfileMenu();
    }
  }
  
  // ===== USER DROPDOWN FUNCTIONS =====
  
  function toggleUserDropdown(event) {
    if (event) {
      event.stopPropagation();
    }
    
    if (!userDropdown) return;
    
    const isOpen = !userDropdown.classList.contains('hidden');
    
    if (isOpen) {
      userDropdown.classList.add('hidden', 'opacity-0', 'scale-95');
      userDropdown.classList.remove('opacity-100', 'scale-100');
    } else {
      userDropdown.classList.remove('hidden');
      userDropdown.offsetHeight;
      userDropdown.classList.add('opacity-100', 'scale-100');
      userDropdown.classList.remove('opacity-0', 'scale-95');
    }
  }
  
  function handleUserDropdownClickOutside(event) {
    if (!userDropdownContainer || !userDropdown) return;
    
    const isClickInsideContainer = userDropdownContainer.contains(event.target);
    const isDropdownOpen = !userDropdown.classList.contains('hidden');
    
    if (!isClickInsideContainer && isDropdownOpen) {
      userDropdown.classList.add('hidden', 'opacity-0', 'scale-95');
      userDropdown.classList.remove('opacity-100', 'scale-100');
    }
  }

  function initializeDropdowns() {
    menuItems.forEach(item => {
      const button = item.querySelector('button');
      const content = item.querySelector('div');
      const arrow = item.querySelector('svg');

      button?.addEventListener('click', () => {
        menuItems.forEach(otherItem => {
          if (otherItem !== item) {
            const otherContent = otherItem.querySelector('div');
            const otherArrow = otherItem.querySelector('svg');
            otherContent?.classList.add('hidden');
            otherArrow?.classList.remove('rotate-90');
          }
        });

        content?.classList.toggle('hidden');
        arrow?.classList.toggle('rotate-90');
      });
    });
  }

  function initializeSwipeHandler() {
    if (!mobileMenu) return;

    let touchStartX = 0;
    let touchEndX = 0;

    mobileMenu.addEventListener('touchstart', e => {
      touchStartX = e.changedTouches[0].screenX;
    });

    mobileMenu.addEventListener('touchend', e => {
      touchEndX = e.changedTouches[0].screenX;
      if (touchStartX - touchEndX > 50) {
        closeMenu();
      }
    });
  }

  function handleClickOutside(event) {
    if (!menuButton || !mobileMenu) return;

    const isClickInsideButton = menuButton.contains(event.target);
    const isClickInsideMenu = mobileMenu.contains(event.target);
    const isMenuOpen = !mobileMenu.classList.contains('-translate-x-full');

    if (!isClickInsideButton && !isClickInsideMenu && isMenuOpen) {
      closeMenu();
    }
  }
  
  // ===== SEARCH FUNCTIONS =====
  
  if (searchContainer) {
    if (searchInput) {
      searchInput.disabled = true;
      searchInput.style.pointerEvents = 'none';
    }
    
    const searchOverlay = document.createElement('div');
    searchOverlay.id = 'search-touch-overlay';
    searchOverlay.style.position = 'absolute';
    searchOverlay.style.inset = '0';
    searchOverlay.style.zIndex = '15';
    searchOverlay.style.cursor = 'pointer';
    searchContainer.appendChild(searchOverlay);
  }
  
  let isSearchExpanded = false;
  let searchTimeout = null;
  
  function handleSearchIconClick(e) {
    e.preventDefault();
    e.stopPropagation();
    
    if (!isSearchExpanded) {
      expandSearch();
    } else if (searchInput.value.trim() === '') {
      collapseSearch();
    } else {
      window.location.href = `/search?q=${encodeURIComponent(searchInput.value.trim())}`;
    }
  }
  
  function expandSearch() {
    if (!searchContainer || !searchInput) return;
    
    const searchOverlay = document.getElementById('search-touch-overlay');
    
    searchContainer.style.width = '95%';
    searchContainer.style.backgroundColor = 'rgba(1, 26, 48, 0.7)';
    searchContainer.style.borderRadius = '20px';
    
    if (searchIcon) {
      searchIcon.style.right = '10px';
    }
    
    setTimeout(() => {
      if (searchOverlay) {
        searchOverlay.style.display = 'none';
      }
      
      searchInput.disabled = false;
      searchInput.style.pointerEvents = 'auto';
      searchInput.style.opacity = '1';
      searchInput.style.paddingLeft = '15px';
      
      setTimeout(() => {
        searchInput.focus();
      }, 100);
      
      isSearchExpanded = true;
    }, 300);
  }
  
  function collapseSearch() {
    if (!searchContainer || !searchInput) return;
    
    const searchOverlay = document.getElementById('search-touch-overlay');
    
    searchInput.blur();
    searchInput.disabled = true;
    searchInput.style.pointerEvents = 'none';
    searchInput.style.opacity = '0';
    searchInput.style.paddingLeft = '0';
    
    if (searchOverlay) {
      searchOverlay.style.display = 'block';
    }
    
    setTimeout(() => {
      searchContainer.style.width = '40px';
      searchContainer.style.backgroundColor = 'transparent';
      searchContainer.style.borderRadius = '9999px';
      
      if (searchIcon) {
        searchIcon.style.right = '10px';
      }
      
      searchInput.value = '';
      
      window.dispatchEvent(new CustomEvent('mobile-search-clear'));
      
      isSearchExpanded = false;
    }, 200);
  }
  
  if (searchInput) {
    searchInput.addEventListener('input', function() {
      const query = searchInput.value.trim();
      
      if (searchTimeout) clearTimeout(searchTimeout);
      
      searchTimeout = setTimeout(() => {
        window.dispatchEvent(new CustomEvent('mobile-search-input', { 
          detail: { query: query } 
        }));
      }, 300);
    });
    
    searchInput.addEventListener('keydown', function(event) {
      if (event.key === 'Enter' && searchInput.value.trim() !== '') {
        window.location.href = `/search?q=${encodeURIComponent(searchInput.value.trim())}`;
      }
      
      if (event.key === 'Escape') {
        collapseSearch();
      }
    });
  }
  
  // ===== EVENT LISTENERS =====
  
  if (menuButton) {
    menuButton.addEventListener('click', function(e) {
      toggleMenu();
    });
  }
  
  if (profileButton) {
    profileButton.addEventListener('click', function(e) {
      toggleProfileMenu(e);
    });
  }
  
  if (mobileMenuOverlay) {
    mobileMenuOverlay.addEventListener('click', closeMenu);
  }
  
  if (profileMenuOverlay) {
    profileMenuOverlay.addEventListener('click', (e) => toggleProfileMenu(e));
  }
  
  document.addEventListener('click', handleClickOutside);
  document.addEventListener('click', handleProfileMenuClick);
  document.addEventListener('click', handleUserDropdownClickOutside);
  
  if (userDropdownButton) {
    userDropdownButton.addEventListener('click', toggleUserDropdown);
  }
  
  if (searchIcon) {
    searchIcon.addEventListener('click', handleSearchIconClick);
  }
  
  const searchOverlay = document.getElementById('search-touch-overlay');
  if (searchOverlay) {
    searchOverlay.addEventListener('click', handleSearchIconClick);
  }
  
  document.addEventListener('click', (e) => {
    if (isSearchExpanded && searchContainer && !searchContainer.contains(e.target)) {
      collapseSearch();
    }
  });
  
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && isSearchExpanded) {
      collapseSearch();
    }
  });
  
  window.addEventListener('resize', () => {
    if (isSearchExpanded && searchContainer) {
      searchContainer.style.width = '95%';
    }
  });

  initializeDropdowns();
  initializeSwipeHandler();
  updateMenuIcon();

  window.toggleProfileMenu = toggleProfileMenu;
});
