# CinEmad 🎬


<div align="center">
  <a href="https://github.com/ersync/cinemad" target="_blank">
	<img src="https://github.com/user-attachments/assets/768fd756-aead-4fa4-9d84-d9eca7414933" width="400" alt="Inception Movie Page"/>
	<img src="https://github.com/user-attachments/assets/1dcec9bc-c0f1-4962-b444-e20d19300e1a" width="400" alt="Home Page"/>
  </a>
</div>


A feature-rich film discovery platform built with Ruby on Rails and Vue.js


**[✨ Live Demo](https://cinemad.emadrahimi.dev) | [Portfolio](https://emadrahimi.dev)**


## Table of Contents
- [Overview](#overview)
- [Key Features](#key-features)
- [Tech Stack](#tech-stack)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)
- [Architecture](#architecture)
- [Lessons Learned](#lessons-learned)
- [License](#license)

## Overview

CinEmad began as a "final challenge" learning project but evolved into a comprehensive film platform that rivals commercial alternatives like TMDB. The project demonstrates advanced full-stack development techniques across a modern tech stack, implementing complex features while maintaining clean architecture and responsive design.

## Key Features

- **Comprehensive movie database** with detailed film information
- **Clean RESTful API** with secure authentication using Devise
- **Reactive frontend** using Vue's state management and real-time updates
- **Media galleries** featuring posters, backdrops, and videos
- **Responsive design** optimized for mobile and desktop experiences
- **User profiles** with watchlists, favorites, ratings, and reviews
- **Advanced search and filtering** across multiple criteria

The codebase spans over 400 files and 25,000 lines of code, including +100 Vue components and +30 ActiveRecord models.

## Tech Stack

**Frontend:**
- Vue.js 3 (Composition API)
- Vue Router for navigation
- Pinia for state management
- Tailwind CSS for styling
- Vite for build tooling

**Backend:**
- Ruby on Rails 7
- PostgreSQL database
- Active Storage for media handling

**Authentication:**
- Devise

**Testing:**
- RSpec

## Screenshots

<div align="center">
  <table>
	<tr>
	  <td><img src="https://github.com/user-attachments/assets/f379d3d9-af42-4967-885a-10e0e4b1b3f8" width="300" alt="Movie Show Page"></td>
	  <td><img src="https://github.com/user-attachments/assets/4ee5f324-a010-4afb-ad0c-0f2798e3e2ff" width="300" alt="Movie Discovery Page"></td>
	  <td><img src="https://github.com/user-attachments/assets/65a86d20-f11f-4df6-9829-e213a81bb3a3" width="300" alt="Login Page"></td>
	</tr>
	<tr>
	  <td><img src="https://github.com/user-attachments/assets/1070bce3-eb83-49cc-9ff7-528084038225" width="300" alt="Mobile Show Page"></td>
	  <td><img src="https://github.com/user-attachments/assets/0bdda4e6-7de5-4ef2-94b9-a5b829050b22" width="300" alt="Mobile Show Page"></td>
	  <td><img src="https://github.com/user-attachments/assets/62da52f8-672b-43a4-b6c4-8cf7757f7da0" width="300" alt="Mobile Search Feature"></td>
	</tr>
  </table>
</div>

## Getting Started

### Prerequisites

- Ruby 3.0+
- Node.js 16+
- PostgreSQL 12+
- Yarn

### Installation

```bash
# Clone the repository
git clone https://github.com/ersync/cinemad.git
cd cinemad

# Install dependencies
bundle install
yarn install

# Setup database and attach media assets
bin/rails db:create db:migrate db:seed
bin/rails movies:setup_all  # All-in-one task that sets up people and movies media
```

### Running Locally

Start the development servers (in separate terminals):

```bash
# Terminal 1: Rails API server
bin/rails server

# Terminal 2: Vite development server for Vue frontend
bin/vite dev
```

Then visit `http://localhost:3000` in your browser.

## Architecture

### Frontend

The Vue.js frontend features a sophisticated component architecture:

- **100+ Vue Components**: Organized in a maintainable hierarchy for reusability
- **State Management**: Uses Pinia with four specialized stores:
  - `auth`: Handles user authentication state
  - `movies`: Manages movie data and filtering
  - `userInteraction`: Tracks ratings, reviews, and watchlist actions
  - `loading`: Controls loading states and UI feedback

### Backend

The Rails API implements a clean architecture with:

- **30+ ActiveRecord models** with complex relationships
- **PORO Pattern**: Extensive use of Plain Old Ruby Objects for business logic
- **Service Objects**: Dedicated classes for complex operations and external integrations
- **Serializers**: Custom JSON serialization for optimized API responses
- **Skinny Controllers**: Controllers delegating to service objects for maintainable code
- **Advanced filtering system** combining multiple criteria (genres, release dates, languages)
- **Rake Tasks**: Composable tasks with an all-in-one setup command

### Mobile-First Design

The application was designed with mobile users in mind first:

- Device-specific components where appropriate
- Touch-friendly interfaces with appropriate tap targets
- Optimized media loading for various connection speeds

## Lessons Learned

This project taught me more than just Rails and Vue fundamentals:

- **Managing complexity** in large codebases
- **Planning component architecture** for maintainability
- **Performance optimization** for media-heavy applications
- **Progressive enhancement** for diverse user devices

CinEmad represents my growth from tutorial-follower to confident full-stack developer capable of building complex applications from the ground up.

## License

MIT License