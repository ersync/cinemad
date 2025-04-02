puts "Destroying existing data..."
User.destroy_all
Movie.destroy_all
Person.destroy_all
MoviePerson.destroy_all
Role.destroy_all
Category.destroy_all
puts "Data destroyed."

# Create users
User.create!(
  username: "FilmFanatic",
  email: "filmfanatic@example.com",
  password: "password123",
  password_confirmation: "password123"
)

User.create!(
  username: "CinematicSoul",
  email: "cinematicsoul@example.com",
  password: "password123",
  password_confirmation: "password123"
)

User.create!(
  username: "ReelCritic",
  email: "reelcritic@example.com",
  password: "password123",
  password_confirmation: "password123"
)

User.create!(
  username: "SceneSeeker",
  email: "sceneseeker@example.com",
  password: "password123",
  password_confirmation: "password123"
)

User.create!(
  username: "DirectorsDream",
  email: "directorsdream@example.com",
  password: "password123",
  password_confirmation: "password123"
)

User.create!(
  username: "FrameByFrame",
  email: "framebyframe@example.com",
  password: "password123",
  password_confirmation: "password123"
)

User.create!(
  username: "ScreenLegend",
  email: "screenlegend@example.com",
  password: "password123",
  password_confirmation: "password123"
)

User.create!(
  username: "MovieMaven",
  email: "moviemaven@example.com",
  password: "password123",
  password_confirmation: "password123"
)

User.create!(
  username: "PopcornPundit",
  email: "popcornpundit@example.com",
  password: "password123",
  password_confirmation: "password123"
)

User.create!(
  username: "FilmBuffExtraordinaire",
  email: "filmbuff@example.com",
  password: "password123",
  password_confirmation: "password123"
)


Category.create!([{ name: 'horror' }, { name: 'thriller' }, { name: 'mystery' }, { name: 'crime' }, { name: 'action' }, { name: 'science fiction' }, { name: 'drama' }])

Role.create!([{ name: 'cast' }, { name: 'director' }, { name: 'writer' }, { name: 'screenplay' }, { name: 'story' }, { name: 'novel' }, { name: 'characters' }])



# --- Create Movies ---

puts "Creating movies..."

movies = {}

movies["The Shawshank Redemption"] = Movie.create!(title: "The Shawshank Redemption", language: "en", age_rating: "R", budget: "25000000.00", duration: 142, release_date: Date.new(1994, 9, 23), revenue: "28341469.00", tagline: "Fear can hold you prisoner. Hope can set you free.", overview: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.", image_filename: "the_shawshank_redemption.jpg", gradient_color: "#4A3F51")
movies["The Godfather"] = Movie.create!(title: "The Godfather", language: "en", age_rating: "R", budget: "6000000.00", duration: 175, release_date: Date.new(1972, 3, 14), revenue: "245066411.00", tagline: "An offer you can't refuse.", overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.", image_filename: "the_godfather.jpg", gradient_color: "#483D5B")
movies["The Dark Knight"] = Movie.create!(title: "The Dark Knight", language: "en", age_rating: "PG-13", budget: "185000000.00", duration: 152, release_date: Date.new(2008, 7, 18), revenue: "1003045358.00", tagline: "Why so serious?", overview: "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.", image_filename: "the_dark_knight.jpg", gradient_color: "#1A1E2A")
movies["Inception"] = Movie.create!(title: "Inception",
  language: "en",
  age_rating: "PG-13",
  budget: "160000000.00",
  duration: 148,
  release_date: Date.new(2010, 7, 15),
  revenue: "839030630.00",
  tagline: "Your mind is the scene of the crime.",
  overview: "Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: \"inception\", the implantation of another person's idea into a target's subconscious.",
  image_filename: "inception.jpg", gradient_color: "#113D4B")
movies["The Matrix"] = Movie.create!(title: "The Matrix", language: "en", age_rating: "R", budget: "63000000.00", duration: 136, release_date: Date.new(1999, 3, 31), revenue: "463517383.00", tagline: "Believe the unbelievable.", overview: "Set in the 22nd century, The Matrix tells the story of a computer hacker who joins a group of underground insurgents fighting the vast and powerful computers who now rule the earth.", image_filename: "the_matrix.jpg", gradient_color: "#2A3045")
movies["GoodFellas"] = Movie.create!(title: "GoodFellas", language: "en", age_rating: "R", budget: "25000000.00", duration: 145, release_date: Date.new(1990, 9, 12), revenue: "46800000.00", tagline: "Three decades of life in the mafia.", overview: "The true story of Henry Hill, a half-Irish, half-Sicilian Brooklyn kid who is adopted by neighbourhood gangsters at an early age and climbs the ranks of a Mafia family under the guidance of Jimmy Conway.", image_filename: "goodfellas.jpg", gradient_color: "#4A4470")
movies["The Others"] = Movie.create!(title: "The Others", language: "en", age_rating: "PG-13", budget: "17000000.00", duration: 104, release_date: Date.new(2001, 8, 2), revenue: "210002906.00", tagline: "Sooner or later they’ll find you.", overview: "Grace is a religious woman who lives in an old house kept dark because her two children, Anne and Nicholas, have a rare sensitivity to light. When the family begins to suspect the house is haunted, Grace fights to protect her children at any cost in the face of strange events and disturbing visions.", image_filename: "the_others.jpg", gradient_color: "#113D4B")
movies["Rush Hour"] = Movie.create!(title: "Rush Hour", language: "en", age_rating: "PG-13", budget: "33000000.00", duration: 97, release_date: Date.new(1998, 9, 18), revenue: "244721064.00", tagline: "The fastest hands in the East meet the biggest mouth in the West.", overview: "When Hong Kong Inspector Lee is summoned to Los Angeles to investigate a kidnapping, the FBI doesn't want any outside help and assigns cocky LAPD Detective James Carter to distract Lee from the case. Not content to watch the action from the sidelines, Lee and Carter form an unlikely partnership and investigate the case themselves.", image_filename: "rush_hour.jpg", gradient_color: "#2D2A42")
movies["Home Alone"] = Movie.create!(title: "Home Alone", language: "en", age_rating: "PG", budget: "18000000.00", duration: 103, release_date: Date.new(1990, 11, 16), revenue: "476684675.00", tagline: "A family comedy without the family.", overview: "Eight-year-old Kevin McCallister makes the most of the situation after his family unwittingly leaves him behind when they go on Christmas vacation. When thieves try to break into his home, he puts up a fight like no other.", image_filename: "home_alone.jpg", gradient_color: "#2A3B47")
movies["The Mask"] = Movie.create!(title: "The Mask", language: "en", age_rating: "PG-13", budget: "23000000.00", duration: 101, release_date: Date.new(1994, 7, 29), revenue: "351583407.00", tagline: "From zero to hero.", overview: "When timid bank clerk Stanley Ipkiss discovers a magical mask containing the spirit of the Norse god Loki, his entire life changes. While wearing the mask, Ipkiss becomes a supernatural playboy exuding charm and confidence which allows him to catch the eye of local nightclub singer Tina Carlyle. Unfortunately, under the mask's influence, Ipkiss also robs a bank, which angers junior crime lord Dorian Tyrell, whose goons get blamed for the heist.", image_filename: "the_mask.jpg", gradient_color: "#113D4B")
movies["The Conjuring"] = Movie.create!(title: "The Conjuring", language: "en", age_rating: "PG-13", budget: "13000000.00", duration: 112, release_date: Date.new(2013, 7, 18), revenue: "320415166.00", tagline: "Based on the true case files of the Warrens.", overview: "Paranormal investigators Ed and Lorraine Warren work to help a family terrorized by a dark presence in their farmhouse. Forced to confront a powerful entity, the Warrens find themselves caught in the most terrifying case of their lives.", image_filename: "the_conjuring.jpg", gradient_color: "#483D5B")
movies["John Wick"] = Movie.create!(title: "John Wick", language: "en", age_rating: "PG-13", budget: "20000000.00", duration: 101, release_date: Date.new(2014, 10, 22), revenue: "88761661.00", tagline: "Don't set him off.", overview: "Ex-hitman John Wick comes out of retirement to track down the gangsters that took everything from him.", image_filename: "john_wick.jpg", gradient_color: "#2A3045")
movies["Interstellar"] = Movie.create!(title: "Interstellar", language: "en", age_rating: "PG-13", budget: "165000000.00", duration: 169, release_date: Date.new(2014, 11, 5), revenue: "746606706.00", tagline: "Mankind was born on Earth. It was never meant to die here.", overview: "The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.", image_filename: "interstellar.jpg", gradient_color: "#8791a2")
movies["Dune"] = Movie.create!(title: "Dune", language: "en", age_rating: "PG-13", budget: "165000000.00", duration: 155, release_date: Date.new(2021, 9, 15), revenue: "407573628.00", tagline: "It begins.", overview: "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.", image_filename: "dune.jpg", gradient_color: "#2A1E14")
movies["Avatar"] = Movie.create!(title: "Avatar", language: "en", age_rating: "PG-13", budget: "237000000.00", duration: 162, release_date: Date.new(2009, 12, 15), revenue: "2923706026.00", tagline: "Enter the world of Pandora.", overview: "In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.", image_filename: "avatar.jpg", gradient_color: "#0A2C3D")
movies["Edge of Tomorrow"] = Movie.create!(title: "Edge of Tomorrow", language: "en", age_rating: "PG-13", budget: "178000000.00", duration: 114, release_date: Date.new(2014, 5, 27), revenue: "370541256.00", tagline: "Live. Die. Repeat.", overview: "Major Bill Cage is an officer who has never seen a day of combat when he is unceremoniously demoted and dropped into combat. Cage is killed within minutes, managing to take an alpha alien down with him. He awakens back at the beginning of the same day and is forced to fight and die again... and again - as physical contact with the alien has thrown him into a time loop.", image_filename: "edge_of_tomorrow.jpg", gradient_color: "#2A3B47")
movies["Oppenheimer"] = Movie.create!(title: "Oppenheimer", language: "en", age_rating: "R", budget: "100000000.00", duration: 181, release_date: Date.new(2023, 7, 19), revenue: "952000000.00", tagline: "The world forever changes.", overview: "The story of J. Robert Oppenheimer's role in the development of the atomic bomb during World War II.", image_filename: "oppenheimer.jpg", gradient_color: "#5E3F4E")
movies["Spider-Man: No Way Home"] = Movie.create!(title: "Spider-Man: No Way Home", language: "en", age_rating: "PG-13", budget: "200000000.00", duration: 148, release_date: Date.new(2021, 12, 15), revenue: "1901232550.00", tagline: "The Multiverse unleashed.", overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.", image_filename: "spider_man_no_way_home.jpg", gradient_color: "#2A1A3A")
movies["Fast Five"] = Movie.create!(title: "Fast Five", language: "en", age_rating: "PG-13", budget: "125000000.00", duration: 130, release_date: Date.new(2011, 4, 20), revenue: "626100000.00", tagline: "Get the fifth gear.", overview: "Former cop Brian O'Conner partners with ex-con Dom Toretto on the opposite side of the law. Since Brian and Mia Toretto broke Dom out of custody, they've blown across many borders to elude authorities. Now backed into a corner in Rio de Janeiro, they must pull one last job in order to gain their freedom.", image_filename: "fast_five.jpg", gradient_color: "#2D2D33")
movies["The Departed"] = Movie.create!(title: "The Departed", language: "en", age_rating: "R", budget: "90000000.00", duration: 151, release_date: Date.new(2006, 10, 4), revenue: "291465000.00", tagline: "Cops or criminals. When you’re facing a loaded gun, what’s the difference?", overview: "To take down South Boston's Irish Mafia, the police send in one of their own to infiltrate the underworld, not realizing the syndicate has done likewise. While an undercover cop curries favor with the mob kingpin, a career criminal rises through the police ranks. But both sides soon discover there's a mole among them.", image_filename: "the_departed.jpg", gradient_color: "#2D1F1D")
movies["Heat"] = Movie.create!(title: "Heat", language: "en", age_rating: "R", budget: "60000000.00", duration: 170, release_date: Date.new(1995, 12, 15), revenue: "187400000.00", tagline: "A Los Angeles crime saga.", overview: "Obsessive master thief Neil McCauley leads a top-notch crew on various daring heists throughout Los Angeles while determined detective Vincent Hanna pursues him without rest. Each man recognizes and respects the ability and the dedication of the other even though they are aware their cat-and-mouse game may end in violence.", image_filename: "heat.jpg", gradient_color: "#2A3045")
movies["Casino"] = Movie.create!(title: "Casino", language: "en", age_rating: "PG-13", budget: "50000000.00", duration: 179, release_date: Date.new(1995, 11, 22), revenue: "116112375.00", tagline: "No one stays at the top forever.", overview: "In early-1970s Las Vegas, Sam \"Ace\" Rothstein gets tapped by his bosses to head the Tangiers Casino. At first, he's a great success in the job, but over the years, problems with his loose-cannon enforcer Nicky Santoro, his ex-hustler wife Ginger, her con-artist ex Lester Diamond and a handful of corrupt politicians put Sam in ever-increasing danger.", image_filename: "casino.jpg", gradient_color: "#2A1A1E")
movies["A Quiet Place"] = Movie.create!(title: "A Quiet Place", language: "en", age_rating: "PG-13", budget: "17000000.00", duration: 91, release_date: Date.new(2018, 4, 3), revenue: "340955294.00", tagline: "If they hear you, they hunt you.", overview: "A family is forced to live in silence while hiding from creatures that hunt by sound.", image_filename: "a_quiet_place.jpg", gradient_color: "#1A1A1F")
movies["The Ring"] = Movie.create!(title: "The Ring", language: "en", age_rating: "PG-13", budget: "48000000.00", duration: 115, release_date: Date.new(2002, 10, 18), revenue: "249348933.00", tagline: "Before you die, you see the Ring.", overview: "Rachel Keller is a journalist investigating a videotape that may have killed four teenagers. There is an urban legend about this tape: the viewer will die seven days after watching it. Rachel tracks down the video... and watches it. Now she has just seven days to unravel the mystery of the Ring so she can save herself and her son.", image_filename: "the_ring.jpg", gradient_color: "#2A2A3D")
movies["Insidious"] = Movie.create!(title: "Insidious", language: "en", age_rating: "PG-13", budget: "1500000.00", duration: 102, release_date: Date.new(2011, 3, 31), revenue: "100106454.00", tagline: "It's not the House that's Haunted.", overview: "A family discovers that dark spirits have invaded their home after their son inexplicably falls into an endless sleep. When they reach out to a professional for help, they learn things are a lot more personal than they thought.", image_filename: "insidious.jpg", gradient_color: "#1A2A3A")
movies["21 Jump Street"] = Movie.create!(title: "21 Jump Street", language: "en", age_rating: "R", budget: "42000000.00", duration: 109, release_date: Date.new(2012, 3, 14), revenue: "201585328.00", tagline: "The only thing getting blown tonight is their cover.", overview: "When cops Schmidt and Jenko join the secret Jump Street unit, they use their youthful appearances to go undercover as high school students. They trade in their guns and badges for backpacks, and set out to shut down a dangerous drug ring. But, as time goes on, Schmidt and Jenko discover that high school is nothing like it was just a few years earlier -- and, what's more, they must again confront the teenage terror and anxiety they thought they had left behind.", image_filename: "21_jump_street.jpg", gradient_color: "#2A3A4A")
movies["Fight Club"] = Movie.create!(title: "Fight Club", language: "en", age_rating: "R", budget: "63000000.00", duration: 139, release_date: Date.new(1999, 10, 15), revenue: "100853753.00", tagline: "Mischief. Mayhem. Soap.", overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground 'fight clubs' forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.", image_filename: "fight_club.jpg", gradient_color: "#0A2C3D")
movies["Ice Age"] = Movie.create!(title: "Ice Age", language: "en", age_rating: "PG", budget: "59000000.00", duration: 81, release_date: Date.new(2002, 3, 10), revenue: "383257136.00", tagline: "They came. They thawed. They conquered.", overview: "With the impending ice age almost upon them, a mismatched trio of prehistoric critters – Manny the woolly mammoth, Diego the saber-toothed tiger and Sid the giant sloth – find an orphaned infant and decide to return it to its human parents. Along the way, the unlikely allies become friends but, when enemies attack, their quest takes on far nobler aims.", image_filename: "ice_age.jpg", gradient_color: "#2C4A63")
movies["Jurassic Park"] = Movie.create!(title: "Jurassic Park", language: "en", age_rating: "PG-13", budget: "63000000.00", duration: 127, release_date: Date.new(1993, 6, 11), revenue: "920100000.00", tagline: "An adventure 65 million years in the making.", overview: "A wealthy entrepreneur secretly creates a theme park featuring living dinosaurs drawn from prehistoric DNA. Before opening day, he invites a team of experts and his two eager grandchildren to experience the park and help calm anxious investors. However, the park is anything but amusing as the security systems go off-line and the dinosaurs escape.", image_filename: "jurassic_park.jpg", gradient_color: "#2A3045")
movies["Inside Out"] = Movie.create!(title: "Inside Out", language: "en", age_rating: "PG", budget: "175000000.00", duration: 95, release_date: Date.new(2015, 6, 17), revenue: "857611174.00", tagline: "Meet the little voices inside your head.", overview: "When 11-year-old Riley moves to a new city, her Emotions team up to help her through the transition. Joy, Fear, Anger, Disgust and Sadness work together, but when Joy and Sadness get lost, they must journey through unfamiliar places to get back home.", image_filename: "inside_out.jpg", gradient_color: "#2A3A4A")
movies["Joker"] = Movie.create!(title: "Joker", language: "en", age_rating: "PG-13", budget: "55000000.00", duration: 122, release_date: Date.new(2019, 10, 1), revenue: "1078958629.00", tagline: "Put on a happy face.", overview: "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.", image_filename: "joker.jpg", gradient_color: "#2A3045")
movies["The Hunger Games"] = Movie.create!(title: "The Hunger Games",
  language: "en",
  age_rating: "PG-13",
  budget: "75000000.00",
  duration: 142,
  release_date: Date.new(2012, 3, 12),
  revenue: "694394724.00",
  tagline: "May the odds be ever in your favor.",
  overview: "Every year in the ruins of what was once North America, the nation of Panem forces each of its twelve districts to send a teenage boy and girl to compete in the Hunger Games. Part twisted entertainment, part government intimidation tactic, the Hunger Games are a nationally televised event in which \"Tributes\" must fight with one another until one survivor remains. Pitted against highly-trained Tributes who have prepared for these Games their entire lives, Katniss is forced to rely upon her sharp instincts as well as the mentorship of drunken former victor Haymitch Abernathy. If she's ever to return home to District 12, Katniss must make impossible choices in the arena that weigh survival against humanity and life against love. The world will be watching.",
  image_filename: "the_hunger_games.jpg", gradient_color: "#4A1C24")
movies["The Lord of the Rings: The Fellowship of the Ring"] = Movie.create!(title: "The Lord of the Rings: The Fellowship of the Ring",
  language: "en",
  age_rating: "PG-13",
  budget: "93000000.00",
  duration: 179,
  release_date: Date.new(2001, 12, 19),
  revenue: "871368364.00",
  tagline: "One ring to rule them all.",
  overview: "Young hobbit Frodo Baggins, after inheriting a mysterious ring from his uncle Bilbo, must leave his home in order to keep it from falling into the hands of its evil creator. Along the way, a fellowship is formed to protect the ringbearer and make sure that the ring arrives at its final destination: Mt. Doom, the only place where it can be destroyed.",
  image_filename: "the_lord_of_the_rings_the_fellowship_of_the_ring.jpg", gradient_color: "#2A3045")
puts "Movies created."



# --- Create People (Actors, Directors, etc.) ---

puts "Creating people..."

people = {}

def add_person(people, name, profession, gender, dob, pob, bio, image, credits)
  key = name.downcase.gsub(/\s+/, "")
  unless people.key?(key)
    people[key] = Person.create!(
      name: name,
      profession: profession,
      gender: gender,
      date_of_birth: dob,
      place_of_birth: pob,
      biography: bio,
      image_filename: image,
      credits: credits
    )
  end
  people[key]
end

# --- People for "The Shawshank Redemption" ---
person_192 = add_person(people, "Morgan Freeman", "actor", "male", "1937-06-01", "Memphis, Tennessee, USA", "", "morgan_freeman.jpg", 211)
person_6574 = add_person(people, "Clancy Brown", "actor", "male", "1959-01-05", " Urbana, Ohio, U.S.", "", "clancy_brown.jpg", 157)
person_504 = add_person(people, "Tim Robbins", "actor", "male", "1958-10-16", "West Covina, California, USA", "", "tim_robbins.jpg", 112)
person_4029 = add_person(people, "Bob Gunton", "actor", "male", "1945-11-15", "Santa Monica, California, USA", "", "bob_gunton.jpg", 89)
person_6573 = add_person(people, "William Sadler", "actor", "male", "1950-04-13", "Buffalo, New York, USA", "", "william_sadler.jpg", 106)
person_6575 = add_person(people, "Gil Bellows", "actor", "male", "1967-06-28", "Vancouver, British Columbia, Canada", "", "gil_bellows.jpg", 80)
person_6580 = add_person(people, "Brian Libby", "actor", "male", "1949-04-20", "Valeggio sul Mincio, Veneto, Verona, Italy", "", "brian_libby.jpg", 28)
person_52603 = add_person(people, "Alfonso Freeman", "actor", "male", "1959-09-13", "Los Angeles, California, USA", "", "alfonso_freeman.jpg", 16)
person_6577 = add_person(people, "James Whitmore", "actor", "male", "1921-10-01", "White Plains, New York, USA", "", "james_whitmore.jpg", 82)
person_8693 = add_person(people, "Jude Ciccolella", "actor", "male", "1947-11-30", "Burlington - Vermont - USA", "", "jude_ciccolella.jpg", 48)

# --- People for "The Godfather" ---
person_1158 = add_person(people, "Al Pacino", "actor", "male", "1940-04-25", "New York City, New York, USA", "", "al_pacino.jpg", 132)
person_3092 = add_person(people, "Diane Keaton", "actor", "female", "1946-01-05", "Los Angeles, California, USA", "", "diane_keaton.jpg", 100)
person_3087 = add_person(people, "Robert Duvall", "actor", "male", "1931-01-05", "San Diego, California, USA", "", "robert_duvall.jpg", 145)
person_3084 = add_person(people, "Marlon Brando", "actor", "male", "1924-04-03", "Omaha, Nebraska, USA", "", "marlon_brando.jpg", 113)
person_3085 = add_person(people, "James Caan", "actor", "male", "1940-03-26", "The Bronx, New York City, New York, USA", "", "james_caan.jpg", 141)
person_3094 = add_person(people, "Talia Shire", "actor", "female", "1946-04-25", "Lake Success, New York, USA", "", "talia_shire.jpg", 86)
person_3145 = add_person(people, "Simonetta Stefanelli", "actor", "female", "1954-11-30", "Rome, Lazio, Italy", "", "simonetta_stefanelli.jpg", 21)
person_3088 = add_person(people, "Sterling Hayden", "actor", "male", "1916-03-26", "Upper Montclair, New Jersey, USA", "", "sterling_hayden.jpg", 73)
person_82779 = add_person(people, "Vito Scotti", "actor", "male", "1918-01-26", "San Francisco, California, USA", "", "vito_scotti.jpg", 60)
person_1769 = add_person(people, "Sofia Coppola", "actor", "female", "1971-05-14", "New York City, New York, USA", "", "sofia_coppola.jpg", 88)

# --- People for "The Dark Knight" ---
person_64 = add_person(people, "Gary Oldman", "actor", "male", "1958-03-21", "London, England, UK", "", "gary_oldman.jpg", 128)
person_2037 = add_person(people, "Cillian Murphy", "actor", "male", "1976-05-25", "Douglas, Cork, Ireland", "", "cillian_murphy.jpg", 74)
person_3895 = add_person(people, "Michael Caine", "actor", "male", "1933-03-14", "Rotherhithe, London, England, UK", "", "michael_caine.jpg", 203)
person_64856 = add_person(people, "Michael Jai White", "actor", "male", "1967-11-10", "Brooklyn, New York City, New York, USA", "", "michael_jai_white.jpg", 112)
person_3894 = add_person(people, "Christian Bale", "actor", "male", "1974-01-30", "Haverfordwest, Pembrokeshire, Wales, UK", "", "christian_bale.jpg", 80)
person_1810 = add_person(people, "Heath Ledger", "actor", "male", "1979-04-04", "Perth, Western Australia, Australia", "", "heath_ledger.jpg", 29)
person_1579 = add_person(people, "Maggie Gyllenhaal", "actor", "female", "1977-11-16", "Lower East Side, New York City, New York, USA", "", "maggie_gyllenhaal.jpg", 63)
person_1904 = add_person(people, "Anthony Michael Hall", "actor", "male", "1968-04-14", "Boston, Massachusetts, USA", "", "anthony_michael_hall.jpg", 72)
person_21315 = add_person(people, "Eric Roberts", "actor", "male", "1956-04-18", "Biloxi, Mississippi, USA", "", "eric_roberts.jpg", 624)

# --- People for "Inception" ---
person_6193 = add_person(people, "Leonardo DiCaprio", "actor", "male", "1974-11-11", "Los Angeles, California, USA", "", "leonardo_dicaprio.jpg", 130)
person_2524 = add_person(people, "Tom Hardy", "actor", "male", "1977-09-15", "Hammersmith, London, England, UK", "", "tom_hardy.jpg", 77)
person_24045 = add_person(people, "Joseph Gordon-Levitt", "actor", "male", "1981-02-17", "Los Angeles, California, USA", "", "joseph_gordon-levitt.jpg", 102)
person_27578 = add_person(people, "Elliot Page", "actor", "other", "1987-02-21", "Halifax, Nova Scotia, Canada", "", "elliot_page.jpg", 65)
person_8293 = add_person(people, "Marion Cotillard", "actor", "female", "1975-09-30", "Paris, France", "", "marion_cotillard.jpg", 128)
person_526 = add_person(people, "Lukas Haas", "actor", "male", "1976-04-16", "West Hollywood, California, USA", "", "lukas_haas.jpg", 77)
person_66441 = add_person(people, "Talulah Riley", "actor", "female", "1985-09-26", "Hertfordshire, England, UK", "", "talulah_riley.jpg", 24)
person_13022 = add_person(people, "Tom Berenger", "actor", "male", "1949-05-31", "Chicago, Illinois, USA", "", "tom_berenger.jpg", 104)

# --- People for "The Matrix" ---
person_6384 = add_person(people, "Keanu Reeves", "actor", "male", "1964-09-02", "Beirut, Lebanon", "", "keanu_reeves.jpg", 158)
person_2975 = add_person(people, "Laurence Fishburne", "actor", "male", "1961-07-30", "Augusta, Georgia, USA", "", "laurence_fishburne.jpg", 0)
person_532 = add_person(people, "Joe Pantoliano", "actor", "male", "1951-09-12", "Hoboken, New Jersey, USA", "", "joe_pantoliano.jpg", 0)
person_530 = add_person(people, "Carrie-Anne Moss", "actor", "female", "1967-08-21", "Burnaby, British Columbia, Canada", "", "carrie-anne_moss.jpg", 58)
person_1331 = add_person(people, "Hugo Weaving", "actor", "male", "1960-04-04", "Ibadan, Nigeria", "", "hugo_weaving.jpg", 104)
person_39545 = add_person(people, "Robert Taylor", "actor", "male", "1963-11-12", "Melbourne, Victoria, Australia", "", "robert_taylor.jpg", 33)
person_9372 = add_person(people, "Marcus Chong", "actor", "male", "1967-07-08", " Seattle, Washington, USA", "", "marcus_chong.jpg", 16)
person_9364 = add_person(people, "Gloria Foster", "actor", "female", "1933-11-15", "Chicago, Illinois, USA", "", "gloria_foster.jpg", 16)
person_181214 = add_person(people, "Ada Nicodemou", "actor", "female", "1977-05-14", "Auburn, Sydney, Australia", "", "ada_nicodemou.jpg", 2)
person_9376 = add_person(people, "Belinda McClory", "actor", "female", "1968-11-01", "Adelaide, South Australia, Australia", "", "belinda_mcclory.jpg", 19)

puts "People created (part 1)."



# --- People for "GoodFellas" ---
person_380 = add_person(people, "Robert De Niro", "actor", "male", "1943-08-17", "Greenwich Village, New York City, New York, USA", "", "robert_de_niro.jpg", 249)
person_2231 = add_person(people, "Samuel L. Jackson", "actor", "male", "1948-12-21", "Washington, D.C., USA", "", "samuel_l_jackson.jpg", 253)
person_4517 = add_person(people, "Joe Pesci", "actor", "male", "1943-02-09", "Newark, New Jersey, USA ", "", "joe_pesci.jpg", 57)
person_5578 = add_person(people, "Debi Mazar", "actor", "female", "1964-08-13", "New York City, New York, USA", "", "debi_mazar.jpg", 72)
person_11486 = add_person(people, "Michael Imperioli", "actor", "male", "1966-03-26", "Mount Vernon, New York, USA", "", "michael_imperioli.jpg", 84)
person_11477 = add_person(people, "Ray Liotta", "actor", "male", "1954-12-18", "Newark, New Jersey, USA", "", "ray_liotta.jpg", 108)
person_21490 = add_person(people, "Peter Onorati", "actor", "male", "1954-05-13", "Boonton, New Jersey, USA", "", "peter_onorati.jpg", 39)
person_93620 = add_person(people, "Welker White", "actor", "female", "1964-09-01", "USA", "", "welker_white.jpg", 36)
person_11478 = add_person(people, "Lorraine Bracco", "actor", "female", "1954-10-02", "Bay Ridge, Brooklyn, New York City, New York, USA", "", "lorraine_bracco.jpg", 53)
person_2144 = add_person(people, "Tobin Bell", "actor", "male", "1942-08-07", "Queens, New York City, New York, USA", "", "tobin_bell.jpg", 91)

# --- People for "The Others" ---
person_2227 = add_person(people, "Nicole Kidman", "actor", "female", "1967-06-20", "Honolulu, Hawaii, USA", "", "nicole_kidman.jpg", 121)
person_58068 = add_person(people, "Fionnula Flanagan", "actor", "female", "1941-12-10", "Dublin, Ireland", "", "fionnula_flanagan.jpg", 77)
person_2040 = add_person(people, "Christopher Eccleston", "actor", "male", "1964-02-16", "Salford, Lancashire, England, UK", "", "christopher_eccleston.jpg", 77)
person_20057 = add_person(people, "Michelle Fairley", "actor", "female", "1963-07-11", "Coleraine, County Londonderry, Northern Ireland, UK", "", "michelle_fairley.jpg", 38)
person_20056 = add_person(people, "Keith Allen", "actor", "male", "1953-06-02", "Gorseinon, Glamorgan, Wales, UK", "", "keith_allen.jpg", 112)
person_20055 = add_person(people, "Renée Asherson", "actor", "female", "1915-05-19", "Kensington, London, England, UK", "", "renée_asherson.jpg", 29)
person_20051 = add_person(people, "Alakina Mann", "actor", "female", "1990-08-01", "Surrey, England, UK", "", "alakina_mann.jpg", 3)
person_20052 = add_person(people, "James Bentley", "actor", "male", "1992-07-14", "", "", "james_bentley.jpg", 3)
person_20054 = add_person(people, "Elaine Cassidy", "actor", "female", "1979-12-31", "Kilcoole, Wicklow, Ireland", "", "elaine_cassidy.jpg", 23)
person_20053 = add_person(people, "Eric Sykes", "actor", "male", "1923-05-04", "Oldham, Lancashire, England, UK", "", "eric_sykes.jpg", 62)

# --- People for "Rush Hour" ---
person_18897 = add_person(people, "Jackie Chan", "actor", "male", "1954-04-07", "Victoria Peak, Hong Kong", "", "jackie_chan.jpg", 381)
person_66 = add_person(people, "Chris Tucker", "actor", "male", "1971-08-31", "Atlanta, Georgia, USA", "", "chris_tucker.jpg", 33)
person_207 = add_person(people, "Tom Wilkinson", "actor", "male", "1948-02-05", "Leeds, England, UK", "", "tom_wilkinson.jpg", 106)
person_21629 = add_person(people, "Tzi Ma", "actor", "male", "1962-06-10", "Hong Kong, British Crown Colony [now China]", "", "tzi_ma.jpg", 50)
person_2131 = add_person(people, "Ken Leung", "actor", "male", "1970-01-21", "New York City, New York, USA", "", "ken_leung.jpg", 30)
person_7430 = add_person(people, "Elizabeth Peña", "actor", "female", "1959-09-23", "Elizabeth, New Jersey, USA", "", "elizabeth_peña.jpg", 61)
person_16937 = add_person(people, "Rex Linn", "actor", "male", "1956-11-13", "Spearman, Texas, USA", "", "rex_linn.jpg", 59)
person_2969 = add_person(people, "Chris Penn", "actor", "male", "1965-10-10", "Los Angeles, California, USA", "", "chris_penn.jpg", 57)
person_16580 = add_person(people, "George Cheung", "actor", "male", "1949-02-08", "Hong Kong, British Crown Colony", "", "george_cheung.jpg", 94)
person_58924 = add_person(people, "Clifton Powell", "actor", "male", "1956-03-16", "Washington, District of Columbia, USA", "", "clifton_powell.jpg", 160)


# --- People for "Home Alone" ---
person_18793 = add_person(people, "Kieran Culkin", "actor", "male", "1982-09-30", "New York City, New York, USA", "", "kieran_culkin.jpg", 29)
person_11510 = add_person(people, "Macaulay Culkin", "actor", "male", "1980-08-26", "New York City, New York, USA", "", "macaulay_culkin.jpg", 47)
person_11514 = add_person(people, "Catherine O'Hara", "actor", "female", "1954-03-04", "Toronto, Ontario, Canada", "", "catherine_ohara.jpg", 90)
person_7180 = add_person(people, "John Candy", "actor", "male", "1950-10-30", "Toronto, Ontario, Canada", "", "john_candy.jpg", 78)
person_11516 = add_person(people, "Devin Ratray", "actor", "male", "1977-01-11", "New York City, New York, USA", "", "devin_ratray.jpg", 34)
person_15250 = add_person(people, "Hope Davis", "actor", "female", "1964-03-23", "Englewood, New Jersey, USA", "", "hope_davis.jpg", 49)
person_11511 = add_person(people, "Daniel Stern", "actor", "male", "1957-08-28", "Bethesda, Maryland, USA", "", "daniel_stern.jpg", 60)
person_11512 = add_person(people, "John Heard", "actor", "male", "1946-03-07", "Washington, District of Columbia, USA", "", "john_heard.jpg", 124)
person_11515 = add_person(people, "Angela Goethals", "actor", "female", "1977-05-20", "New York City, New York, USA", "", "angela_goethals.jpg", 13)

# --- People for "The Mask" ---
person_206 = add_person(people, "Jim Carrey", "actor", "male", "1962-01-17", "Newmarket, Ontario, Canada", "", "jim_carrey.jpg", 92)
person_6941 = add_person(people, "Cameron Diaz", "actor", "female", "1972-08-30", "San Diego, California, USA", "", "cameron_diaz.jpg", 68)
person_956385 = add_person(people, "Meadow Williams", "actor", "female", "1966-02-10", "Miami, Florida, USA", "", "meadow_williams.jpg", 43)
person_20899 = add_person(people, "Peter Riegert", "actor", "male", "1947-04-11", "New York City, New York, USA", "", "peter_riegert.jpg", 65)
person_11803 = add_person(people, "Peter Greene", "actor", "male", "1965-10-08", "Montclair, New Jersey, USA", "", "peter_greene.jpg", 64)
person_42168 = add_person(people, "Nancy Fish", "actor", "female", "1938-03-16", "Spokane, Washington, USA", "", "nancy_fish.jpg", 39)
person_75923 = add_person(people, "Christopher Darga", "actor", "male", "", "", "", "christopher_darga.jpg", 24)
person_53400 = add_person(people, "Tim Bagley", "actor", "male", "1957-08-17", "Minneapolis, Minnesota, U.S.", "", "tim_bagley.jpg", 33)
person_15372 = add_person(people, "Jeremy Roberts", "actor", "male", "1954-09-18", "Birmingham, Alabama, USA", "", "jeremy_roberts.jpg", 26)
person_1219 = add_person(people, "Amy Yasbeck", "actor", "female", "1962-09-12", "Cincinnati, Ohio, USA", "", "amy_yasbeck.jpg", 23)

# --- People for "The Conjuring" ---
person_125025 = add_person(people, "Joey King", "actor", "female", "1999-07-30", "Los Angeles, California, USA", "", "joey_king.jpg", 52)
person_21657 = add_person(people, "Vera Farmiga", "actor", "female", "1973-08-06", "Clifton, New Jersey, USA", "", "vera_farmiga.jpg", 64)
person_17178 = add_person(people, "Patrick Wilson", "actor", "male", "1973-07-03", "Norfolk, Virginia, USA", "", "patrick_wilson.jpg", 63)
person_17402 = add_person(people, "Ron Livingston", "actor", "male", "1967-06-05", "Cedar Rapids, Iowa, USA", "", "ron_livingston.jpg", 74)
person_851784 = add_person(people, "Mackenzie Foy", "actor", "female", "2000-11-10", "Los Angeles, California, USA", "", "mackenzie_foy.jpg", 14)
person_63663 = add_person(people, "Hayley McFarland", "actor", "female", "1991-03-29", "Edmond, Oklahoma, USA", "", "hayley_mcfarland.jpg", 8)
person_3127 = add_person(people, "Lili Taylor", "actor", "female", "1967-02-20", "Glencoe, Illinois, USA", "", "lili_taylor.jpg", 0)
person_73417 = add_person(people, "Joseph Bishara", "actor", "male", "1970-07-26", "New Brunswick, New Jersey, USA", "", "joseph_bishara.jpg", 55)
person_80619 = add_person(people, "Steve Coulter", "actor", "male", "1960-01-01", "USA", "", "steve_coulter.jpg", 58)
person_1186840 = add_person(people, "Sterling Jerins", "actor", "female", "2004-06-15", "New York City, New York, USA", "", "sterling_jerins.jpg", 17)

puts "People created (part 2)."


# --- People for "John Wick" ---
person_6384 = add_person(people, "Keanu Reeves", "actor", "male", "1964-09-02", "Beirut, Lebanon", "", "keanu_reeves.jpg", 158)
person_5293 = add_person(people, "Willem Dafoe", "actor", "male", "1955-07-22", "Appleton, Wisconsin, USA", "", "willem_dafoe.jpg", 218)
person_6972 = add_person(people, "Ian McShane", "actor", "male", "1942-09-29", "Blackburn, Lancashire, England, UK", "", "ian_mcshane.jpg", 101)
person_5723 = add_person(people, "John Leguizamo", "actor", "male", "1960-07-22", " Bogotá, Colombia", "", "john_leguizamo.jpg", 162)
person_1222298 = add_person(people, "Bridget Regan", "actor", "female", "1982-02-03", "Carlsbad, California, USA", "", "bridget_regan.jpg", 14)
person_129101 = add_person(people, "Lance Reddick", "actor", "male", "1962-06-07", "Baltimore, Maryland, USA", "", "lance_reddick.jpg", 54)
person_71586 = add_person(people, "Alfie Allen", "actor", "male", "1986-09-12", "Hammersmith, London, England, UK", "", "alfie_allen.jpg", 31)
person_18354 = add_person(people, "Bridget Moynahan", "actor", "female", "1971-04-28", "Binghamton, New York, USA", "", "bridget_moynahan.jpg", 23)
person_88995 = add_person(people, "Adrianne Palicki", "actor", "female", "1983-05-06", "Toledo, Ohio, USA", "", "adrianne_palicki.jpg", 27)
person_1737 = add_person(people, "David Patrick Kelly", "actor", "male", "1951-01-23", "Detroit, Michigan, USA", "", "david_patrick_kelly.jpg", 53)

# --- People for "Interstellar" ---
person_1190668 = add_person(people, "Timothée Chalamet", "actor", "male", "1995-12-27", "Manhattan, New York City, New York, USA", "", "timothée_chalamet.jpg", 0)
person_1813 = add_person(people, "Anne Hathaway", "actor", "female", "1982-11-12", "Brooklyn, New York City, New York, USA", "", "anne_hathaway.jpg", 92)
person_1892 = add_person(people, "Matt Damon", "actor", "male", "1970-10-08", "Boston, Massachusetts, USA", "", "matt_damon.jpg", 152)
person_12074 = add_person(people, "John Lithgow", "actor", "male", "1945-10-19", "Rochester, New York, USA", "", "john_lithgow.jpg", 143)
person_10297 = add_person(people, "Matthew McConaughey", "actor", "male", "1969-11-04", "Uvalde, Texas, USA", "", "matthew_mcconaughey.jpg", 90)
person_3895 = add_person(people, "Michael Caine", "actor", "male", "1933-03-14", "Rotherhithe, London, England, UK", "", "michael_caine.jpg", 203)
person_8210 = add_person(people, "Wes Bentley", "actor", "male", "1978-09-04", "Jonesboro, Arkansas, USA", "", "wes_bentley.jpg", 48)
person_83002 = add_person(people, "Jessica Chastain", "actor", "female", "1977-03-24", "Southern California, California, USA", "", "jessica_chastain.jpg", 88)
person_17052 = add_person(people, "Topher Grace", "actor", "male", "1978-07-12", "New York City, New York, USA", "", "topher_grace.jpg", 41)
person_1893 = add_person(people, "Casey Affleck", "actor", "male", "1975-08-12", "Falmouth, Massachusetts, USA", "", "casey_affleck.jpg", 72)

# --- People for "Dune" ---
person_1190668 = add_person(people, "Timothée Chalamet", "actor", "male", "1995-12-27", "Manhattan, New York City, New York, USA", "", "timothée_chalamet.jpg", 0)
person_933238 = add_person(people, "Rebecca Ferguson", "actor", "female", "1983-10-19", "Stockholm, Sweden", "", "rebecca_ferguson.jpg", 29)
person_505710 = add_person(people, "Zendaya", "actor", "female", "1996-09-01", "Oakland, California, USA", "", "zendaya.jpg", 36)
person_117642 = add_person(people, "Jason Momoa", "actor", "male", "1979-08-01", "Honolulu, Hawaii, USA", "", "jason_momoa.jpg", 69)
person_25072 = add_person(people, "Oscar Isaac", "actor", "male", "1979-03-09", "Guatemala City, Guatemala", "", "oscar_isaac.jpg", 83)
person_16851 = add_person(people, "Josh Brolin", "actor", "male", "1968-02-12", "Santa Monica, Los Angeles, California, USA", "", "josh_brolin.jpg", 89)
person_543530 = add_person(people, "Dave Bautista", "actor", "male", "1969-01-18", "Washington, D.C., USA", "", "dave_bautista.jpg", 180)
person_3810 = add_person(people, "Javier Bardem", "actor", "male", "1969-03-01", "Las Palmas de Gran Canaria, Gran Canaria, Canary Islands, Spain", "", "javier_bardem.jpg", 85)
person_1640 = add_person(people, "Stellan Skarsgård", "actor", "male", "1951-06-13", "Gothenburg, Västra Götalands län, Sweden", "", "stellan_skarsgård.jpg", 159)
person_44079 = add_person(people, "Charlotte Rampling", "actor", "female", "1946-02-05", "England, UK", "", "charlotte_rampling.jpg", 147)

# --- People for "Avatar" ---
person_8691 = add_person(people, "Zoe Saldaña", "actor", "female", "1978-06-19", "Passaic, New Jersey, USA", "", "zoe_saldaña.jpg", 84)
person_10205 = add_person(people, "Sigourney Weaver", "actor", "female", "1949-10-08", "Manhattan, New York City, New York, USA", "", "sigourney_weaver.jpg", 129)
person_17647 = add_person(people, "Michelle Rodriguez", "actor", "female", "1978-07-12", "Bexar County, Texas, USA", "", "michelle_rodriguez.jpg", 53)
person_65731 = add_person(people, "Sam Worthington", "actor", "male", "1976-08-02", "Surrey, England, UK ", "", "sam_worthington.jpg", 62)
person_1771 = add_person(people, "Giovanni Ribisi", "actor", "male", "1974-12-17", "Los Angeles, California, USA", "", "giovanni_ribisi.jpg", 69)
person_32747 = add_person(people, "Stephen Lang", "actor", "male", "1952-07-11", "New York, New York, U.S", "", "stephen_lang.jpg", 116)
person_10964 = add_person(people, "Laz Alonso", "actor", "male", "1974-03-25", "Washington, District of Columbia, USA", "", "laz_alonso.jpg", 36)
person_68278 = add_person(people, "Peter Mensah", "actor", "male", "1959-08-27", "Chiraa, Ghana", "", "peter_mensah.jpg", 25)
person_30485 = add_person(people, "CCH Pounder", "actor", "female", "1952-12-25", "Georgetown, British Guiana [now Guyana]", "", "cch_pounder.jpg", 71)
person_83105 = add_person(people, "Debra Wilson", "actor", "female", "1962-04-26", "New York City, New York, USA", "", "debra_wilson.jpg", 76)

# --- People for "Edge of Tomorrow" ---
person_500 = add_person(people, "Tom Cruise", "actor", "male", "1962-07-03", "Syracuse, New York, USA", "", "tom_cruise.jpg", 107)
person_5081 = add_person(people, "Emily Blunt", "actor", "female", "1983-02-23", "Wandsworth, London, England, UK", "", "emily_blunt.jpg", 59)
person_2053 = add_person(people, "Bill Paxton", "actor", "male", "1955-05-17", "Fort Worth, Texas, USA", "", "bill_paxton.jpg", 102)
person_2039 = add_person(people, "Brendan Gleeson", "actor", "male", "1955-03-29", "Dublin, Ireland", "", "brendan_gleeson.jpg", 95)
person_1284 = add_person(people, "Noah Taylor", "actor", "male", "1969-09-04", "London, England, UK", "", "noah_taylor.jpg", 56)
person_115679 = add_person(people, "Charlotte Riley", "actor", "female", "1981-12-29", "Grindon, England, UK", "", "charlotte_riley.jpg", 15)
person_1504934 = add_person(people, "Bentley Kalu", "actor", "male", "1985-04-07", "London, England, UK", "", "bentley_kalu.jpg", 26)
person_84490 = add_person(people, "David Kaye", "actor", "male", "1964-10-14", "Peterborough, Ontario, Canada", "", "david_kaye.jpg", 75)
person_213083 = add_person(people, "Lara Pulver", "actor", "female", "1980-09-01", "Kent, England, UK", "", "lara_pulver.jpg", 9)
person_1211881 = add_person(people, "Beth Goddard", "actor", "female", "1969-11-28", "London, England ", "", "beth_goddard.jpg", 13)

# --- People for "Oppenheimer" ---
person_64 = add_person(people, "Gary Oldman", "actor", "male", "1958-03-21", "London, England, UK", "", "gary_oldman.jpg", 128)
person_3223 = add_person(people, "Robert Downey Jr.", "actor", "male", "1965-04-04", "New York City, New York, USA", "", "robert_downey_jr.jpg", 137)
person_2037 = add_person(people, "Cillian Murphy", "actor", "male", "1976-05-25", "Douglas, Cork, Ireland", "", "cillian_murphy.jpg", 74)
person_1892 = add_person(people, "Matt Damon", "actor", "male", "1970-10-08", "Boston, Massachusetts, USA", "", "matt_damon.jpg", 152)
person_1373737 = add_person(people, "Florence Pugh", "actor", "female", "1996-01-03", "Oxford, Oxfordshire, England UK", "", "florence_pugh.jpg", 37)
person_1030513 = add_person(people, "Jack Quaid", "actor", "male", "1992-04-24", "Los Angeles, California, USA", "", "jack_quaid.jpg", 30)
person_17838 = add_person(people, "Rami Malek", "actor", "male", "1981-05-12", "Torrance, California, USA", "", "rami_malek.jpg", 34)
person_5081 = add_person(people, "Emily Blunt", "actor", "female", "1983-02-23", "Wandsworth, London, England, UK", "", "emily_blunt.jpg", 59)
person_2299 = add_person(people, "Josh Hartnett", "actor", "male", "1978-07-21", "Saint Paul, Minnesota, USA", "", "josh_hartnett.jpg", 55)
person_11181 = add_person(people, "Kenneth Branagh", "actor", "male", "1960-12-10", "Belfast, Northern Ireland, UK", "", "kenneth_branagh.jpg", 154)

puts "People created (part 3)."



# --- People for "Spider-Man: No Way Home" ---
person_37625 = add_person(people, "Andrew Garfield", "actor", "male", "1983-08-20", "Los Angeles, California, USA", "", "andrew_garfield.jpg", 42)
person_1136406 = add_person(people, "Tom Holland", "actor", "male", "1996-06-01", "Surrey, England, UK", "", "tom_holland.jpg", 43)
person_2524 = add_person(people, "Tom Hardy", "actor", "male", "1977-09-15", "Hammersmith, London, England, UK", "", "tom_hardy.jpg", 77)
person_505710 = add_person(people, "Zendaya", "actor", "female", "1996-09-01", "Oakland, California, USA", "", "zendaya.jpg", 36)
person_18999 = add_person(people, "J.K. Simmons", "actor", "male", "1955-01-09", "Detroit, Michigan, USA", "", "jk_simmons.jpg", 149)
person_71580 = add_person(people, "Benedict Cumberbatch", "actor", "male", "1976-07-19", "Hammersmith, London, England, UK", "", "benedict_cumberbatch.jpg", 118)
person_5293 = add_person(people, "Willem Dafoe", "actor", "male", "1955-07-22", "Appleton, Wisconsin, USA", "", "willem_dafoe.jpg", 218)
person_134 = add_person(people, "Jamie Foxx", "actor", "male", "1967-12-13", "Terrell, Texas, USA", "", "jamie_foxx.jpg", 123)
person_15277 = add_person(people, "Jon Favreau", "actor", "male", "1966-10-19", "Queens, New York City, New York, USA", "", "jon_favreau.jpg", 107)
person_2219 = add_person(people, "Tobey Maguire", "actor", "male", "1975-06-27", "Santa Monica, California, USA", "", "tobey_maguire.jpg", 60)

# --- People for "Fast Five" ---
person_12835 = add_person(people, "Vin Diesel", "actor", "male", "1967-07-18", "Alameda County, California, USA", "", "vin_diesel.jpg", 87)
person_18918 = add_person(people, "Dwayne Johnson", "actor", "male", "1972-05-02", "Hayward, California, USA", "", "dwayne_johnson.jpg", 313)
person_8167 = add_person(people, "Paul Walker", "actor", "male", "1973-09-12", "Glendale, California, USA", "", "paul_walker.jpg", 39)
person_22123 = add_person(people, "Jordana Brewster", "actor", "female", "1980-04-26", "Panama City, Panama", "", "jordana_brewster.jpg", 29)
person_8169 = add_person(people, "Tyrese Gibson", "actor", "male", "1978-12-30", "Los Angeles, California, USA", "", "tyrese_gibson.jpg", 47)
person_73269 = add_person(people, "Elsa Pataky", "actor", "female", "1976-07-18", "Madrid, Spain", "", "elsa_pataky.jpg", 40)
person_8170 = add_person(people, "Eva Mendes", "actor", "female", "1974-03-05", "Miami, Florida, USA", "", "eva_mendes.jpg", 42)
person_61697 = add_person(people, "Sung Kang", "actor", "male", "1972-04-08", "Gainesville, Georgia, USA", "", "sung_kang.jpg", 45)

# --- People for "The Departed" ---
person_6193 = add_person(people, "Leonardo DiCaprio", "actor", "male", "1974-11-11", "Los Angeles, California, USA", "", "leonardo_dicaprio.jpg", 130)
person_1892 = add_person(people, "Matt Damon", "actor", "male", "1970-10-08", "Boston, Massachusetts, USA", "", "matt_damon.jpg", 152)
person_13240 = add_person(people, "Mark Wahlberg", "actor", "male", "1971-06-05", "Boston, Massachusetts, USA", "", "mark_wahlberg.jpg", 105)
person_514 = add_person(people, "Jack Nicholson", "actor", "male", "1937-04-22", "Manhattan, New York, USA", "", "jack_nicholson.jpg", 130)
person_21657 = add_person(people, "Vera Farmiga", "actor", "female", "1973-08-06", "Clifton, New Jersey, USA", "", "vera_farmiga.jpg", 64)
person_7447 = add_person(people, "Alec Baldwin", "actor", "male", "1958-04-03", "Amityville, New York, USA", "", "alec_baldwin.jpg", 223)
person_8349 = add_person(people, "Martin Sheen", "actor", "male", "1940-08-03", "Dayton, Ohio, USA", "", "martin_sheen.jpg", 268)
person_5538 = add_person(people, "Ray Winstone", "actor", "male", "1957-02-19", "Hackney, London, England, UK", "", "ray_winstone.jpg", 111)
person_2257 = add_person(people, "Terry Serpico", "actor", "male", "1964-06-27", "Lawton, Oklahoma, USA", "", "terry_serpico.jpg", 29)
person_18473 = add_person(people, "James Badge Dale", "actor", "male", "1978-05-01", " New York City, New York, USA", "", "james_badge_dale.jpg", 38)

# --- People for "Heat" ---
person_380 = add_person(people, "Robert De Niro", "actor", "male", "1943-08-17", "Greenwich Village, New York City, New York, USA", "", "robert_de_niro.jpg", 249)
person_524 = add_person(people, "Natalie Portman", "actor", "female", "1981-06-09", "Jerusalem, Israel", "", "natalie_portman.jpg", 91)
person_1158 = add_person(people, "Al Pacino", "actor", "male", "1940-04-25", "New York City, New York, USA", "", "al_pacino.jpg", 132)
person_15852 = add_person(people, "Ashley Judd", "actor", "female", "1968-04-19", "Granada Hills, California, USA", "", "ashley_judd.jpg", 61)
person_5576 = add_person(people, "Val Kilmer", "actor", "male", "1959-12-31", "Los Angeles, California, USA", "", "val_kilmer.jpg", 118)
person_12799 = add_person(people, "Jeremy Piven", "actor", "male", "1965-07-26", "Manhattan, New York City, New York, USA", "", "jeremy_piven.jpg", 81)
person_15854 = add_person(people, "Ted Levine", "actor", "male", "1957-05-29", "Parma, Ohio, USA", "", "ted_levine.jpg", 66)
person_10127 = add_person(people, "Jon Voight", "actor", "male", "1938-12-29", "Yonkers, New York, USA", "", "jon_voight.jpg", 127)
person_3197 = add_person(people, "Tom Sizemore", "actor", "male", "1961-11-29", "Detroit, Michigan, USA", "", "tom_sizemore.jpg", 216)
person_11160 = add_person(people, "Danny Trejo", "actor", "male", "1944-05-16", "Los Angeles, California, USA", "", "danny_trejo.jpg", 338)

# --- People for "Casino" ---
person_4517 = add_person(people, "Joe Pesci", "actor", "male", "1943-02-09", "Newark, New Jersey, USA ", "", "joe_pesci.jpg", 57)
person_380 = add_person(people, "Robert De Niro", "actor", "male", "1943-08-17", "Greenwich Village, New York City, New York, USA", "", "robert_de_niro.jpg", 249)
person_4430 = add_person(people, "Sharon Stone", "actor", "female", "1958-03-10", "Meadville, Pennsylvania, USA", "", "sharon_stone.jpg", 145)
person_4512 = add_person(people, "James Woods", "actor", "male", "1947-04-18", "Vernal, Utah, USA", "", "james_woods.jpg", 128)
person_7167 = add_person(people, "Don Rickles", "actor", "male", "1926-05-08", "Queens, New York City, New York, USA", "", "don_rickles.jpg", 80)
person_8262 = add_person(people, "L.Q. Jones", "actor", "male", "1927-08-19", "Beaumont, Texas, USA", "", "lq_jones.jpg", 80)
person_97188 = add_person(people, "Steve Schirripa", "actor", "male", "1957-09-03", "Bensonhurst, Brooklyn, New York City, New York, USA", "", "steve_schirripa.jpg", 37)
person_7166 = add_person(people, "Kevin Pollak", "actor", "male", "1957-10-30", "San Francisco, California, USA", "", "kevin_pollak.jpg", 128)
person_18262 = add_person(people, "Richard Riehle", "actor", "male", "1948-05-12", "Menomonee Falls, Wisconsin, USA", "", "richard_riehle.jpg", 236)
person_7164 = add_person(people, "Frank Vincent", "actor", "male", "1939-08-04", "North Adams, Massachusetts, USA", "", "frank_vincent.jpg", 67)

# --- People for "A Quiet Place" ---
person_5081 = add_person(people, "Emily Blunt", "actor", "female", "1983-02-23", "Wandsworth, London, England, UK", "", "emily_blunt.jpg", 59)
person_17697 = add_person(people, "John Krasinski", "actor", "male", "1979-10-20", "Boston, Massachusetts, USA", "", "john_krasinski.jpg", 79)
person_1590759 = add_person(people, "Noah Jupe", "actor", "male", "2005-02-25", "Islington, London, England, UK", "", "noah_jupe.jpg", 21)
person_169920 = add_person(people, "Leon Russom", "actor", "male", "1941-12-06", "Little Rock, Arkansas, USA", "", "leon_russom.jpg", 38)
person_1815539 = add_person(people, "Millicent Simmonds", "actor", "female", "2003-03-06", "Utah, USA", "", "millicent_simmonds.jpg", 7)
person_1924769 = add_person(people, "Cade Woodward", "actor", "male", "2011-02-16", "", "", "cade_woodward.jpg", 5)
person_1496368 = add_person(people, "Rhoda Pell", "actor", "female", "1947-12-10", "California, USA", "", "rhoda_pell.jpg", 28)

# --- People for "The Ring" ---
person_11702 = add_person(people, "Adam Brody", "actor", "male", "1979-12-15", "San Diego, California, USA", "", "adam_brody.jpg", 56)
person_26291 = add_person(people, "Martin Henderson", "actor", "male", "1974-10-08", "Auckland, New Zealand", "", "martin_henderson.jpg", 29)
person_3489 = add_person(people, "Naomi Watts", "actor", "female", "1968-09-28", "Shoreham, Kent, England, UK", "", "naomi_watts.jpg", 108)
person_1248 = add_person(people, "Brian Cox", "actor", "male", "1946-06-01", "Dundee, Scotland, UK", "", "brian_cox.jpg", 196)
person_11680 = add_person(people, "Pauley Perrette", "actor", "female", "1969-03-27", "New Orleans, Louisiana, USA", "", "pauley_perrette.jpg", 23)
person_10131 = add_person(people, "Sara Rue", "actor", "female", "1979-01-26", "New York City, New York, USA", "", "sara_rue.jpg", 26)
person_20354 = add_person(people, "Amber Tamblyn", "actor", "female", "1983-05-14", "Santa Monica, California, USA", "", "amber_tamblyn.jpg", 34)
person_1580 = add_person(people, "Daveigh Chase", "actor", "female", "1990-07-24", "Las Vegas, Nevada, USA", "", "daveigh_chase.jpg", 26)
person_26294 = add_person(people, "Lindsay Frost", "actor", "female", "1962-06-04", "Minneapolis, Minnesota, USA", "", "lindsay_frost.jpg", 18)
person_13724 = add_person(people, "Jane Alexander", "actor", "female", "1939-10-28", "Boston, Massachusetts, USA", "", "jane_alexander.jpg", 67)

# --- People for "Insidious" ---
person_5293 = add_person(people, "Willem Dafoe", "actor", "male", "1955-07-22", "Appleton, Wisconsin, USA", "", "willem_dafoe.jpg", 218)
person_9827 = add_person(people, "Rose Byrne", "actor", "female", "1979-07-24", "Sydney, New South Wales, Australia", "", "rose_byrne.jpg", 71)
person_17178 = add_person(people, "Patrick Wilson", "actor", "male", "1973-07-03", "Norfolk, Virginia, USA", "", "patrick_wilson.jpg", 63)
person_17181 = add_person(people, "Ty Simpkins", "actor", "male", "2001-08-06", "New York City, New York, USA", "", "ty_simpkins.jpg", 26)
person_10767 = add_person(people, "Barbara Hershey", "actor", "female", "1948-02-05", "Hollywood, California, USA", "", "barbara_hershey.jpg", 89)
person_59117 = add_person(people, "Angus Sampson", "actor", "male", "1979-02-12", "Australia", "", "angus_sampson.jpg", 38)
person_73417 = add_person(people, "Joseph Bishara", "actor", "male", "1970-07-26", "New Brunswick, New Jersey, USA", "", "joseph_bishara.jpg", 55)
person_7401 = add_person(people, "Lin Shaye", "actor", "female", "1943-10-12", "Detroit, Michigan, USA", "", "lin_shaye.jpg", 181)
person_1364121 = add_person(people, "Emily Brobst", "actor", "female", "1984-10-24", "Wisconsin, USA", "", "emily_brobst.jpg", 75)
person_2128 = add_person(people, "Leigh Whannell", "actor", "male", "1977-01-17", "Melbourne, Australia", "", "leigh_whannell.jpg", 108)
person_208524 = add_person(people, "Andrew Astor", "actor", "male", "2000-06-07", "Arizona", "", "andrew_astor.jpg", 7)

# --- People for "21 Jump Street" ---
person_85 = add_person(people, "Johnny Depp", "actor", "male", "1963-06-09", "Owensboro, Kentucky, USA ", "", "johnny_depp.jpg", 165)
person_118545 = add_person(people, "Dakota Johnson", "actor", "female", "1989-10-04", "Austin, Texas, USA", "", "dakota_johnson.jpg", 52)
person_38673 = add_person(people, "Channing Tatum", "actor", "male", "1980-04-26", "Cullman, Alabama, USA", "", "channing_tatum.jpg", 94)
person_60073 = add_person(people, "Brie Larson", "actor", "female", "1989-10-01", "Sacramento, California, USA", "", "brie_larson.jpg", 77)
person_9778 = add_person(people, "Ice Cube", "actor", "male", "1969-06-15", "Los Angeles, California, USA", "", "ice_cube.jpg", 120)
person_54697 = add_person(people, "Dave Franco", "actor", "male", "1985-06-12", "Palo Alto, California, USA", "", "dave_franco.jpg", 56)
person_21007 = add_person(people, "Jonah Hill", "actor", "male", "1983-12-20", "Los Angeles, California, USA", "", "jonah_hill.jpg", 90)
person_17039 = add_person(people, "Nick Offerman", "actor", "male", "1970-06-26", "Joliet, Illinois, USA", "", "nick_offerman.jpg", 96)
person_475512 = add_person(people, "Ellie Kemper", "actor", "female", "1980-05-02", "Kansas City, Missouri, USA", "", "ellie_kemper.jpg", 32)
person_1060081 = add_person(people, "Johnny Pemberton", "actor", "male", "1981-06-01", "Rochester, Minnesota, USA", "", "johnny_pemberton.jpg", 27)

# --- People for "Fight Club" ---
person_1158 = add_person(people, "Al Pacino", "actor", "male", "1940-04-25", "New York City, New York, USA", "", "al_pacino.jpg", 132)
person_287 = add_person(people, "Brad Pitt", "actor", "male", "1963-12-18", "Shawnee, Oklahoma, USA", "", "brad_pitt.jpg", 179)
person_1283 = add_person(people, "Helena Bonham Carter", "actor", "female", "1966-05-26", "Golders Green, London, England, UK", "", "helena_bonham_carter.jpg", 118)
person_819 = add_person(people, "Edward Norton", "actor", "male", "1969-08-18", "Boston, Massachusetts, USA", "", "edward_norton.jpg", 83)
person_7499 = add_person(people, "Jared Leto", "actor", "male", "1971-12-26", "Bossier City, Louisiana, USA", "", "jared_leto.jpg", 80)
person_7497 = add_person(people, "Holt McCallany", "actor", "male", "1963-09-03", "New York City, New York, USA", "", "holt_mccallany.jpg", 60)
person_7498 = add_person(people, "Eion Bailey", "actor", "male", "1976-06-08", "Santa Ynez Valley, California, USA", "", "eion_bailey.jpg", 25)
person_7471 = add_person(people, "Zach Grenier", "actor", "male", "1954-02-12", "Englewood, New Jersey, USA", "", "zach_grenier.jpg", 44)
person_7470 = add_person(people, "Meat Loaf", "actor", "male", "1947-09-27", "Dallas, Texas, USA", "", "meat_loaf.jpg", 90)
person_16060 = add_person(people, "Brian Tochi", "actor", "male", "1963-05-02", "Los Angeles, California, USA", "", "brian_tochi.jpg", 23)
person_9291 = add_person(people, "Michael Shamus Wiles", "actor", "male", "1955-10-27", "Everett, Washington, USA", "", "michael_shamus_wiles.jpg", 60)

# --- People for "Ice Age" ---
person_15757 = add_person(people, "Ray Romano", "actor", "male", "1957-12-21", "Queens, New York City, New York, USA", "", "ray_romano.jpg", 51)
person_5723 = add_person(people, "John Leguizamo", "actor", "male", "1960-07-22", " Bogotá, Colombia", "", "john_leguizamo.jpg", 162)
person_21088 = add_person(people, "Alan Tudyk", "actor", "male", "1971-03-16", "El Paso, Texas, USA", "", "alan_tudyk.jpg", 67)
person_15758 = add_person(people, "Queen Latifah", "actor", "female", "1970-03-18", "Newark, New Jersey, USA ", "", "queen_latifah.jpg", 101)
person_57599 = add_person(people, "Seann William Scott", "actor", "male", "1976-10-03", "Cottage Grove, Minnesota, USA", "", "seann_william_scott.jpg", 50)
person_17401 = add_person(people, "Stephen Root", "actor", "male", "1951-11-17", "Sarasota, Florida, USA", "", "stephen_root.jpg", 120)
person_5724 = add_person(people, "Denis Leary", "actor", "male", "1957-08-18", "Worcester, Massachusetts, USA", "", "denis_leary.jpg", 85)
person_35159 = add_person(people, "Laraine Newman", "actor", "female", "1952-03-02", "Los Angeles, California, USA", "", "laraine_newman.jpg", 117)
person_42160 = add_person(people, "Ariel Winter", "actor", "female", "1998-01-28", "Fairfax, Virginia, USA", "", "ariel_winter.jpg", 59)
person_21200 = add_person(people, "Will Arnett", "actor", "male", "1970-05-04", "Toronto, Ontario, Canada", "", "will_arnett.jpg", 82)

# --- People for "Jurassic Park" ---
person_2231 = add_person(people, "Samuel L. Jackson", "actor", "male", "1948-12-21", "Washington, D.C., USA", "", "samuel_l_jackson.jpg", 253)
person_4784 = add_person(people, "Laura Dern", "actor", "female", "1967-02-10", "Los Angeles, California, USA", "", "laura_dern.jpg", 125)
person_4785 = add_person(people, "Jeff Goldblum", "actor", "male", "1952-10-22", "Pittsburgh, Pennsylvania, USA", "", "jeff_goldblum.jpg", 149)
person_4783 = add_person(people, "Sam Neill", "actor", "male", "1947-09-14", "Omagh, County Tyrone, Northern Ireland, UK", "", "sam_neill.jpg", 163)
person_4201 = add_person(people, "Wayne Knight", "actor", "male", "1955-08-07", "New York City, New York, USA", "", "wayne_knight.jpg", 54)
person_4787 = add_person(people, "Joseph Mazzello", "actor", "male", "1983-09-21", "Rhinebeck, New York, USA", "", "joseph_mazzello.jpg", 40)
person_4786 = add_person(people, "Richard Attenborough", "actor", "male", "1923-08-29", "Cambridge, Cambridgeshire, England, UK", "", "richard_attenborough.jpg", 128)
person_14592 = add_person(people, "BD Wong", "actor", "male", "1960-10-24", "San Francisco, California, USA", "", "bd_wong.jpg", 53)
person_4788 = add_person(people, "Ariana Richards", "actor", "female", "1979-09-11", "Healdsburg, California, USA", "", "ariana_richards.jpg", 23)
person_30488 = add_person(people, "Miguel Sandoval", "actor", "male", "1951-11-16", "Washington, D.C., USA", "", "miguel_sandoval.jpg", 73)

# --- People for "Inside Out" ---
person_2882 = add_person(people, "Diane Lane", "actor", "female", "1965-01-22", "New York City, New York, USA", "", "diane_lane.jpg", 75)
person_6677 = add_person(people, "Kyle MacLachlan", "actor", "male", "1959-02-22", "Yakima, Washington, USA", "", "kyle_maclachlan.jpg", 89)
person_80591 = add_person(people, "Rashida Jones", "actor", "female", "1976-02-25", "Los Angeles, California, USA", "", "rashida_jones.jpg", 64)
person_19278 = add_person(people, "Bill Hader", "actor", "male", "1978-06-07", "Tulsa, Oklahoma, USA", "", "bill_hader.jpg", 103)
person_7907 = add_person(people, "John Ratzenberger", "actor", "male", "1947-04-06", "Bridgeport, Connecticut, USA", "", "john_ratzenberger.jpg", 115)
person_21125 = add_person(people, "Richard Kind", "actor", "male", "1956-11-22", "North Trenton, New Jersey, USA", "", "richard_kind.jpg", 118)
person_35159 = add_person(people, "Laraine Newman", "actor", "female", "1952-03-02", "Los Angeles, California, USA", "", "laraine_newman.jpg", 117)
person_125167 = add_person(people, "Mindy Kaling", "actor", "female", "1979-06-24", "Cambridge, Massachusetts, USA", "", "mindy_kaling.jpg", 39)
person_56322 = add_person(people, "Amy Poehler", "actor", "female", "1971-09-16", "Newton, Massachusetts, USA", "", "amy_poehler.jpg", 95)
person_59784 = add_person(people, "Carlos Alazraqui", "actor", "male", "1962-07-20", "Sacramento, California, USA", "", "carlos_alazraqui.jpg", 146)


# --- People for "Joker" ---
person_380 = add_person(people, "Robert De Niro", "actor", "male", "1943-08-17", "Greenwich Village, New York City, New York, USA", "", "robert_de_niro.jpg", 249)
person_73421 = add_person(people, "Joaquin Phoenix", "actor", "male", "1974-10-28", "San Juan, Puerto Rico", "", "joaquin_phoenix.jpg", 77)
person_15009 = add_person(people, "Justin Theroux", "actor", "male", "1971-08-10", "Washington, D.C., USA", "", "justin_theroux.jpg", 62)
person_121718 = add_person(people, "Bill Camp", "actor", "male", "1964-10-13", "Massachusetts, USA", "", "bill_camp.jpg", 58)
person_1545693 = add_person(people, "Zazie Beetz", "actor", "female", "1991-06-01", "Mitte, Berlin, Germany", "", "zazie_beetz.jpg", 34)
person_74242 = add_person(people, "Shea Whigham", "actor", "male", "1969-01-05", "Tallahassee, Florida, USA", "", "shea_whigham.jpg", 71)
person_226366 = add_person(people, "Brian Tyree Henry", "actor", "male", "1982-03-31", "Fayetteville, North Carolina, USA", "", "brian_tyree_henry.jpg", 35)
person_2551677 = add_person(people, "Isabella Ferreira", "actor", "female", "2002-12-20", "Boston, Massachusetts, USA", "", "isabella_ferreira.jpg", 6)
person_4432 = add_person(people, "Frances Conroy", "actor", "female", "1953-03-15", "Monroe, Georgia, USA", "", "frances_conroy.jpg", 65)
person_1049916 = add_person(people, "Hannah Gross", "actor", "female", "1992-09-25", "West Bloomfield, Michigan, USA", "", "hannah_gross.jpg", 37)

# --- People for "The Hunger Games" ---
person_2231 = add_person(people, "Samuel L. Jackson", "actor", "male", "1948-12-21", "Washington, D.C., USA", "", "samuel_l_jackson.jpg", 253)
person_1030513 = add_person(people, "Jack Quaid", "actor", "male", "1992-04-24", "Los Angeles, California, USA", "", "jack_quaid.jpg", 30)
person_72129 = add_person(people, "Jennifer Lawrence", "actor", "female", "1990-08-15", "Indian Hills, Kentucky, USA", "", "jennifer_lawrence.jpg", 61)
person_57755 = add_person(people, "Woody Harrelson", "actor", "male", "1961-07-23", "Midland, Texas, USA", "", "woody_harrelson.jpg", 152)
person_2283 = add_person(people, "Stanley Tucci", "actor", "male", "1960-11-11", "Peekskill, New York, USA", "", "stanley_tucci.jpg", 135)
person_13014 = add_person(people, "Toby Jones", "actor", "male", "1966-09-07", "Hammersmith, London, England, UK", "", "toby_jones.jpg", 116)

# The Next 3
#
person_8210 = add_person(people, "Wes Bentley", "actor", "male", "1978-09-04", "Jonesboro, Arkansas, USA", "", "wes_bentley.jpg", 48)
person_9281 = add_person(people, "Elizabeth Banks", "actor", "female", "1974-02-10", "Pittsfield, Massachusetts, USA", "", "elizabeth_banks.jpg", 105)
person_5723 = add_person(people, "John Leguizamo", "actor", "male", "1960-07-22", " Bogotá, Colombia", "", "john_leguizamo.jpg", 162)

# --- People for "The Lord of the Rings: The Fellowship of the Ring" ---
person_112 = add_person(people, "Cate Blanchett", "actor", "female", "1969-05-14", "Melbourne, Victoria, Australia", "", "cate_blanchett.jpg", 141)
person_48 = add_person(people, "Sean Bean", "actor", "male", "1959-04-17", "Sheffield, South Yorkshire, England, UK", "", "sean_bean.jpg", 120)
person_110 = add_person(people, "Viggo Mortensen", "actor", "male", "1958-10-20", "Watertown, New York, USA", "", "viggo_mortensen.jpg", 91)
person_3895 = add_person(people, "Michael Caine", "actor", "male", "1933-03-14", "Rotherhithe, London, England, UK", "", "michael_caine.jpg", 203)
person_1327 = add_person(people, "Ian McKellen", "actor", "male", "1939-05-25", "Burnley, Lancashire, England, UK", "", "ian_mckellen.jpg", 151)
person_109 = add_person(people, "Elijah Wood", "actor", "male", "1981-01-28", "Cedar Rapids, Iowa, USA", "", "elijah_wood.jpg", 126)
person_1333 = add_person(people, "Andy Serkis", "actor", "male", "1964-04-20", "Ruislip, Middlesex, England, UK", "", "andy_serkis.jpg", 109)
person_1328 = add_person(people, "Sean Astin", "actor", "male", "1971-02-25", "Santa Monica, California, USA", "", "sean_astin.jpg", 148)
person_108 = add_person(people, "Peter Jackson", "actor", "male", "1961-10-31", "Pukerua Bay, North Island, New Zealand", "", "peter_jackson.jpg", 144)
person_114 = add_person(people, "Orlando Bloom", "actor", "male", "1977-01-13", "Canterbury, Kent, England, UK", "", "orlando_bloom.jpg", 72)
person_655 = add_person(people, "John Rhys-Davies", "actor", "male", "1944-05-05", "Ammanford, Wales, UK", "", "john_rhys-davies.jpg", 183)


puts "People created (part 4 - FINAL)."




def associate_person(movie, person, role_id, character_name, people_hash, movies_hash)
  person_key = person.downcase.gsub(/\s+/, "")

  unless movies_hash.key?(movie)
    puts "ERROR: Movie '#{movie}' not found in movies_hash!"
    return
  end

  unless people_hash.key?(person_key)
    puts "ERROR: Person '#{person}' (key: '#{person_key}') not found in people_hash!"
    return
  end

  movie_id = movies_hash[movie].id
  person_id = people_hash[person_key].id
  role_id = role_id

  MoviePerson.create!(
    movie_id: movie_id,
    person_id: person_id,
    role_id: role_id,
    character_name: character_name
  )
end

# --- The Shawshank Redemption ---
associate_person("The Shawshank Redemption", "Tim Robbins", 1, "Andy Dufresne", people, movies)
associate_person("The Shawshank Redemption", "Morgan Freeman", 1, "Ellis Boyd 'Red' Redding", people, movies)
associate_person("The Shawshank Redemption", "Bob Gunton", 1, "Warden Norton", people, movies)
associate_person("The Shawshank Redemption", "Clancy Brown", 1, "Captain Byron T. Hadley", people, movies)
associate_person("The Shawshank Redemption", "James Whitmore", 1, "Brooks Hatlen", people, movies)
associate_person("The Shawshank Redemption", "William Sadler", 1, "Heywood", people, movies)
associate_person("The Shawshank Redemption", "Gil Bellows", 1, "Tommy Williams", people, movies)
associate_person("The Shawshank Redemption", "Brian Libby", 1, "Floyd", people, movies)
associate_person("The Shawshank Redemption", "Jude Ciccolella", 1, "Guard Mert", people, movies)
associate_person("The Shawshank Redemption", "Alfonso Freeman", 1, "Fresh Fish Con", people, movies)

# --- The Godfather ---
associate_person("The Godfather", "Al Pacino", 1, "Michael Corleone", people, movies)
associate_person("The Godfather", "Marlon Brando", 1, "Don Vito Corleone", people, movies)
associate_person("The Godfather", "James Caan", 1, "Sonny Corleone", people, movies)
associate_person("The Godfather", "Robert Duvall", 1, "Tom Hagen", people, movies)
associate_person("The Godfather", "Diane Keaton", 1, "Kay Adams", people, movies)
associate_person("The Godfather", "Talia Shire", 1, "Connie Corleone Rizzi", people, movies)
associate_person("The Godfather", "Sterling Hayden", 1, "Captain McCluskey", people, movies)
associate_person("The Godfather", "Simonetta Stefanelli", 1, "Apollonia - Sicilian Sequence", people, movies)
associate_person("The Godfather", "Vito Scotti", 1, "Nazorine", people, movies)
associate_person("The Godfather", "Sofia Coppola", 1, "Michael Francis Rizzi", people, movies)

# --- The Dark Knight ---
associate_person("The Dark Knight", "Christian Bale", 1, "Bruce Wayne", people, movies)
associate_person("The Dark Knight", "Heath Ledger", 1, "Joker", people, movies)
associate_person("The Dark Knight", "Aaron Eckhart", 1, "Harvey Dent", people, movies)
associate_person("The Dark Knight", "Michael Caine", 1, "Alfred", people, movies)
associate_person("The Dark Knight", "Gary Oldman", 1, "Gordon", people, movies)
associate_person("The Dark Knight", "Maggie Gyllenhaal", 1, "Rachel", people, movies)
associate_person("The Dark Knight", "Morgan Freeman", 1, "Lucius Fox", people, movies)
associate_person("The Dark Knight", "Eric Roberts", 1, "Maroni", people, movies)
associate_person("The Dark Knight", "Cillian Murphy", 1, "Scarecrow", people, movies)
associate_person("The Dark Knight", "Michael Jai White", 1, "Gambol", people, movies)

# --- Inception ---
associate_person("Inception", "Leonardo DiCaprio", 1, "Dom Cobb", people, movies)
associate_person("Inception", "Joseph Gordon-Levitt", 1, "Arthur", people, movies)
associate_person("Inception", "Elliot Page", 1, "Ariadne", people, movies)
associate_person("Inception", "Tom Hardy", 1, "Eames", people, movies)
associate_person("Inception", "Ken Watanabe", 1, "Saito", people, movies)
associate_person("Inception", "Dileep Rao", 1, "Yusuf", people, movies)
associate_person("Inception", "Cillian Murphy", 1, "Robert Fischer, Jr.", people, movies)
associate_person("Inception", "Marion Cotillard", 1, "Mal Cobb", people, movies)
associate_person("Inception", "Tom Berenger", 1, "Peter Browning", people, movies)
associate_person("Inception", "Michael Caine", 1, "Professor Miles", people, movies)

# --- The Matrix ---
associate_person("The Matrix", "Keanu Reeves", 1, "Neo", people, movies)
associate_person("The Matrix", "Laurence Fishburne", 1, "Morpheus", people, movies)
associate_person("The Matrix", "Carrie-Anne Moss", 1, "Trinity", people, movies)
associate_person("The Matrix", "Hugo Weaving", 1, "Agent Smith", people, movies)
associate_person("The Matrix", "Joe Pantoliano", 1, "Cypher", people, movies)
associate_person("The Matrix", "Marcus Chong", 1, "Tank", people, movies)
associate_person("The Matrix", "Gloria Foster", 1, "Oracle", people, movies)
associate_person("The Matrix", "Anthony Ray Parker", 1, "Dozer", people, movies)
associate_person("The Matrix", "Matt Doran", 1, "Mouse", people, movies)
associate_person("The Matrix", "Belinda McClory", 1, "Switch", people, movies)

puts "MoviePerson associations created (part 1)."

# --- GoodFellas ---
associate_person("GoodFellas", "Robert De Niro", 1, "James Conway", people, movies)
associate_person("GoodFellas", "Ray Liotta", 1, "Henry Hill", people, movies)
associate_person("GoodFellas", "Joe Pesci", 1, "Tommy DeVito", people, movies)
associate_person("GoodFellas", "Lorraine Bracco", 1, "Karen Hill", people, movies)
associate_person("GoodFellas", "Paul Sorvino", 1, "Paul Cicero", people, movies)
associate_person("GoodFellas", "Frank Sivero", 1, "Frankie Carbone", people, movies)
associate_person("GoodFellas", "Tony Darrow", 1, "Sonny Bunz", people, movies)
associate_person("GoodFellas", "Mike Starr", 1, "Frenchy", people, movies)
associate_person("GoodFellas", "Chuck Low", 1, "Morris Kessler", people, movies)
associate_person("GoodFellas", "Frank Vincent", 1, "Billy Batts", people, movies)

# --- The Others ---
associate_person("The Others", "Nicole Kidman", 1, "Grace Stewart", people, movies)
associate_person("The Others", "Fionnula Flanagan", 1, "Mrs. Bertha Mills", people, movies)
associate_person("The Others", "Christopher Eccleston", 1, "Charles Stewart", people, movies)
associate_person("The Others", "Alakina Mann", 1, "Anne Stewart", people, movies)
associate_person("The Others", "James Bentley", 1, "Nicholas Stewart", people, movies)
associate_person("The Others", "Eric Sykes", 1, "Mr. Edmund Tuttle", people, movies)
associate_person("The Others", "Elaine Cassidy", 1, "Lydia", people, movies)
associate_person("The Others", "Renée Asherson", 1, "Old Lady", people, movies)
associate_person("The Others", "Keith Allen", 1, "Mr. Marlish", people, movies)
associate_person("The Others", "Michelle Fairley", 1, "Mrs. Marlish", people, movies)


# --- The Rush Hour ---
associate_person("Rush Hour", "Jackie Chan", 1, "Inspector Lee", people, movies)
associate_person("Rush Hour", "Chris Tucker", 1, "James Carter", people, movies)
associate_person("Rush Hour", "Tom Wilkinson", 1, "Juntao", people, movies)
associate_person("Rush Hour", "Tzi Ma", 1, "Consul Solon Han", people, movies)
associate_person("Rush Hour", "Ken Leung", 1, "Sang", people, movies)
associate_person("Rush Hour", "Elizabeth Peña", 1, "Detective Tania Johnson", people, movies)
associate_person("Rush Hour", "Rex Linn", 1, "FBI Agent Dan Whitney", people, movies)
associate_person("Rush Hour", "Chris Penn", 1, "Clive Cobb", people, movies)
associate_person("Rush Hour", "George Cheung", 1, "Soo Yung's Driver", people, movies)
associate_person("Rush Hour", "Clifton Powell", 1, "Luke", people, movies)

# --- Home Alone ---
associate_person("Home Alone", "Macaulay Culkin", 1, "Kevin", people, movies)
associate_person("Home Alone", "John Candy", 1, "Gus Polinski", people, movies)
associate_person("Home Alone", "Daniel Stern", 1, "Marv", people, movies)
associate_person("Home Alone", "Catherine O'Hara", 1, "Kate", people, movies)
associate_person("Home Alone", "John Heard", 1, "Peter", people, movies)
associate_person("Home Alone", "Devin Ratray", 1, "Buzz", people, movies)
associate_person("Home Alone", "Angela Goethals", 1, "Linnie", people, movies)
associate_person("Home Alone", "Kieran Culkin", 1, "Fuller", people, movies)
associate_person("Home Alone", "Hope Davis", 1, "French Ticket Agent", people, movies)

# --- The Mask ---
associate_person("The Mask", "Jim Carrey", 1, "Stanley Ipkiss / The Mask", people, movies)
associate_person("The Mask", "Cameron Diaz", 1, "Tina Carlyle", people, movies)
associate_person("The Mask", "Meadow Williams", 1, "Pebbles", people, movies)
associate_person("The Mask", "Peter Riegert", 1, "Mitch Kellaway", people, movies)
associate_person("The Mask", "Peter Greene", 1, "Dorian Tyrrell", people, movies)
associate_person("The Mask", "Nancy Fish", 1, "Mrs. Peenman", people, movies)
associate_person("The Mask", "Christopher Darga", 1, "Paramedic #3", people, movies)
associate_person("The Mask", "Tim Bagley", 1, "Irv", people, movies)
associate_person("The Mask", "Jeremy Roberts", 1, "Bobby the Bouncer", people, movies)
associate_person("The Mask", "Amy Yasbeck", 1, "Peggy Brandt", people, movies)

# --- The Conjuring ---
associate_person("The Conjuring", "Joey King", 1, "Christine Perron", people, movies)
associate_person("The Conjuring", "Vera Farmiga", 1, "Lorraine Warren", people, movies)
associate_person("The Conjuring", "Patrick Wilson", 1, "Ed Warren", people, movies)
associate_person("The Conjuring", "Ron Livingston", 1, "Roger Perron", people, movies)
associate_person("The Conjuring", "Mackenzie Foy", 1, "Cindy Perron", people, movies)
associate_person("The Conjuring", "Hayley McFarland", 1, "Nancy Perron", people, movies)
associate_person("The Conjuring", "Lili Taylor", 1, "Carolyn Perron", people, movies)
associate_person("The Conjuring", "Joseph Bishara", 1, "The demon Bathsheba", people, movies)
associate_person("The Conjuring", "Steve Coulter", 1, "Padre Gordon", people, movies)
associate_person("The Conjuring", "Sterling Jerins", 1, "Judy Warren", people, movies)

puts "MoviePerson associations created (part 2)."




# --- John Wick ---
associate_person("John Wick", "Keanu Reeves", 1, "John Wick", people, movies)
associate_person("John Wick", "Willem Dafoe", 1, "Marcus", people, movies)
associate_person("John Wick", "Ian McShane", 1, "Winston", people, movies)
associate_person("John Wick", "John Leguizamo", 1, "Aurelio", people, movies)
associate_person("John Wick", "Bridget Regan", 1, "Addy", people, movies)
associate_person("John Wick", "Lance Reddick", 1, "Charon", people, movies)
associate_person("John Wick", "Alfie Allen", 1, "Iosef Tarasov", people, movies)
associate_person("John Wick", "Bridget Moynahan", 1, "Helen", people, movies)
associate_person("John Wick", "Adrianne Palicki", 1, "Ms. Perkins", people, movies)
associate_person("John Wick", "David Patrick Kelly", 1, "Charlie", people, movies)

# --- Interstellar ---
associate_person("Interstellar", "Matthew McConaughey", 1, "Cooper", people, movies)
associate_person("Interstellar", "Anne Hathaway", 1, "Brand", people, movies)
associate_person("Interstellar", "Jessica Chastain", 1, "Murph", people, movies)
associate_person("Interstellar", "Michael Caine", 1, "Professor Brand", people, movies)
associate_person("Interstellar", "John Lithgow", 1, "Donald", people, movies)
associate_person("Interstellar", "Matt Damon", 1, "Mann", people, movies)
associate_person("Interstellar", "Wes Bentley", 1, "Doyle", people, movies)
associate_person("Interstellar", "Casey Affleck", 1, "Tom", people, movies)
associate_person("Interstellar", "Timothée Chalamet", 1, "Tom (15 Yrs.)", people, movies)
associate_person("Interstellar", "Topher Grace", 1, "Getty", people, movies)

# --- Dune ---
associate_person("Dune", "Timothée Chalamet", 1, "Paul Atreides", people, movies)
associate_person("Dune", "Rebecca Ferguson", 1, "Lady Jessica Atreides", people, movies)
associate_person("Dune", "Oscar Isaac", 1, "Duke Leto Atreides", people, movies)
associate_person("Dune", "Zendaya", 1, "Chani", people, movies)
associate_person("Dune", "Jason Momoa", 1, "Duncan Idaho", people, movies)
associate_person("Dune", "Josh Brolin", 1, "Gurney Halleck", people, movies)
associate_person("Dune", "Stellan Skarsgård", 1, "Baron Vladimir Harkonnen", people, movies)
associate_person("Dune", "Javier Bardem", 1, "Stilgar", people, movies)
associate_person("Dune", "Dave Bautista", 1, "Beast Rabban Harkonnen", people, movies)
associate_person("Dune", "Charlotte Rampling", 1, "Reverend Mother Mohiam", people, movies)

# --- Avatar ---
associate_person("Avatar", "Sam Worthington", 1, "Jake Sully", people, movies)
associate_person("Avatar", "Zoe Saldaña", 1, "Neytiri", people, movies)
associate_person("Avatar", "Sigourney Weaver", 1, "Dr. Grace Augustine", people, movies)
associate_person("Avatar", "Stephen Lang", 1, "Colonel Miles Quaritch", people, movies)
associate_person("Avatar", "Michelle Rodriguez", 1, "Trudy Chacon", people, movies)
associate_person("Avatar", "Giovanni Ribisi", 1, "Parker Selfridge", people, movies)
associate_person("Avatar", "CCH Pounder", 1, "Mo'at", people, movies)
associate_person("Avatar", "Laz Alonso", 1, "Tsu'Tey", people, movies)
associate_person("Avatar", "Peter Mensah", 1, "Horse Clan Leader", people, movies)
associate_person("Avatar", "Debra Wilson", 1, "Troupe", people, movies)

# --- Edge of Tomorrow ---
associate_person("Edge of Tomorrow", "Tom Cruise", 1, "Maj. William 'Bill' Cage", people, movies)
associate_person("Edge of Tomorrow", "Emily Blunt", 1, "Sgt. Rita Vrataski", people, movies)
associate_person("Edge of Tomorrow", "Brendan Gleeson", 1, "General Brigham", people, movies)
associate_person("Edge of Tomorrow", "Bill Paxton", 1, "Master Sergeant Farell", people, movies)
associate_person("Edge of Tomorrow", "Noah Taylor", 1, "Dr. Carter", people, movies)
associate_person("Edge of Tomorrow", "Charlotte Riley", 1, "Nance", people, movies)
associate_person("Edge of Tomorrow", "Bentley Kalu", 1, "Dog Soldier 4", people, movies)
associate_person("Edge of Tomorrow", "David Kaye", 1, "UDF Commercial (voice)", people, movies)
associate_person("Edge of Tomorrow", "Lara Pulver", 1, "Karen Lord", people, movies)
associate_person("Edge of Tomorrow", "Beth Goddard", 1, "Secretary - Judith", people, movies)

# --- Oppenheimer ---
associate_person("Oppenheimer", "Cillian Murphy", 1, "J. Robert Oppenheimer", people, movies)
associate_person("Oppenheimer", "Robert Downey Jr.", 1, "Lewis Strauss", people, movies)
associate_person("Oppenheimer", "Emily Blunt", 1, "Kitty Oppenheimer", people, movies)
associate_person("Oppenheimer", "Matt Damon", 1, "Leslie Groves", people, movies)
associate_person("Oppenheimer", "Florence Pugh", 1, "Jean Tatlock", people, movies)
associate_person("Oppenheimer", "Josh Hartnett", 1, "Ernest Lawrence", people, movies)
associate_person("Oppenheimer", "Rami Malek", 1, "David Hill", people, movies)
associate_person("Oppenheimer", "Kenneth Branagh", 1, "Niels Bohr", people, movies)
associate_person("Oppenheimer", "Jack Quaid", 1, "Richard Feynman", people, movies)

puts "MoviePerson associations created (part 3)."

# --- Spider-Man: No Way Home ---
associate_person("Spider-Man: No Way Home", "Tom Holland", 1, "Peter Parker / Spider-Man", people, movies)
associate_person("Spider-Man: No Way Home", "Zendaya", 1, "MJ", people, movies)
associate_person("Spider-Man: No Way Home", "Benedict Cumberbatch", 1, "Doctor Strange", people, movies)
associate_person("Spider-Man: No Way Home", "Jon Favreau", 1, "Happy Hogan", people, movies)
associate_person("Spider-Man: No Way Home", "Jamie Foxx", 1, "Max Dillon / Electro", people, movies)
associate_person("Spider-Man: No Way Home", "Tom Hardy", 1, "Eddie Brock / Venom (uncredited)", people, movies)
associate_person("Spider-Man: No Way Home", "Willem Dafoe", 1, "Norman Osborn / Green Goblin", people, movies)
associate_person("Spider-Man: No Way Home", "Tobey Maguire", 1, "Peter Parker / Spider-Man", people, movies)
associate_person("Spider-Man: No Way Home", "Andrew Garfield", 1, "Peter Parker / Spider-Man", people, movies)
associate_person("Spider-Man: No Way Home", "J.K. Simmons", 1, "J. Jonah Jameson", people, movies)

# --- Fast Five ---
associate_person("Fast Five", "Vin Diesel", 1, "Dominic Toretto", people, movies)
associate_person("Fast Five", "Paul Walker", 1, "Brian O'Conner", people, movies)
associate_person("Fast Five", "Dwayne Johnson", 1, "Luke Hobbs", people, movies)
associate_person("Fast Five", "Jordana Brewster", 1, "Mia Toretto", people, movies)
associate_person("Fast Five", "Tyrese Gibson", 1, "Roman Pearce", people, movies)
associate_person("Fast Five", "Sung Kang", 1, "Han Lue", people, movies)
associate_person("Fast Five", "Elsa Pataky", 1, "Elena Neves", people, movies)

# --- The Departed ---
associate_person("The Departed", "Leonardo DiCaprio", 1, "Billy", people, movies)
associate_person("The Departed", "Matt Damon", 1, "Colin", people, movies)
associate_person("The Departed", "Mark Wahlberg", 1, "Dignam", people, movies)
associate_person("The Departed", "Jack Nicholson", 1, "Costello", people, movies)
associate_person("The Departed", "Vera Farmiga", 1, "Madolyn", people, movies)
associate_person("The Departed", "Ray Winstone", 1, "Mr. French", people, movies)
associate_person("The Departed", "Alec Baldwin", 1, "Ellerby", people, movies)
associate_person("The Departed", "Martin Sheen", 1, "Queenan", people, movies)
associate_person("The Departed", "James Badge Dale", 1, "Barrigan", people, movies)
associate_person("The Departed", "Terry Serpico", 1, "Detective #3 Tailing Queenan", people, movies)

# --- Heat ---
associate_person("Heat", "Al Pacino", 1, "Lt. Vincent Hanna", people, movies)
associate_person("Heat", "Robert De Niro", 1, "Neil McCauley", people, movies)
associate_person("Heat", "Val Kilmer", 1, "Chris Shiherlis", people, movies)
associate_person("Heat", "Natalie Portman", 1, "Lauren Gustafson", people, movies)
associate_person("Heat", "Tom Sizemore", 1, "Michael Cheritto", people, movies)
associate_person("Heat", "Jon Voight", 1, "Nate", people, movies)
associate_person("Heat", "Ashley Judd", 1, "Charlene Shiherlis", people, movies)
associate_person("Heat", "Ted Levine", 1, "Bosko", people, movies)
associate_person("Heat", "Danny Trejo", 1, "Trejo", people, movies)
associate_person("Heat", "Jeremy Piven", 1, "Dr. Bob", people, movies)

# --- Casino ---
associate_person("Casino", "Robert De Niro", 1, "Sam 'Ace' Rothstein", people, movies)
associate_person("Casino", "Joe Pesci", 1, "Nicky Santoro", people, movies)
associate_person("Casino", "Sharon Stone", 1, "Ginger McKenna", people, movies)
associate_person("Casino", "James Woods", 1, "Lester Diamond", people, movies)
associate_person("Casino", "Don Rickles", 1, "Billy Sherbert", people, movies)
associate_person("Casino", "Kevin Pollak", 1, "Phillip Green", people, movies)
associate_person("Casino", "L.Q. Jones", 1, "Pat Webb", people, movies)
associate_person("Casino", "Frank Vincent", 1, "Frank Marino", people, movies)
associate_person("Casino", "Steve Schirripa", 1, "Man in Bar (uncredited)", people, movies)
associate_person("Casino", "Richard Riehle", 1, "Charlie Clark", people, movies)

# --- A Quiet Place ---
associate_person("A Quiet Place", "John Krasinski", 1, "Lee Abbott", people, movies)
associate_person("A Quiet Place", "Emily Blunt", 1, "Evelyn Abbott", people, movies)
associate_person("A Quiet Place", "Millicent Simmonds", 1, "Regan Abbott", people, movies)
associate_person("A Quiet Place", "Noah Jupe", 1, "Marcus Abbott", people, movies)
associate_person("A Quiet Place", "Leon Russom", 1, "Man in the Woods", people, movies)
associate_person("A Quiet Place", "Cade Woodward", 1, "Beau Abbott", people, movies)
associate_person("A Quiet Place", "Rhoda Pell", 1, "Old Man's Dead Wife (uncredited)", people, movies)

# --- The Ring ---
associate_person("The Ring", "Naomi Watts", 1, "Rachel Keller", people, movies)
associate_person("The Ring", "Martin Henderson", 1, "Noah Clay", people, movies)
associate_person("The Ring", "Adam Brody", 1, "Male Teen #1", people, movies)
associate_person("The Ring", "Brian Cox", 1, "Richard Morgan", people, movies)
associate_person("The Ring", "Daveigh Chase", 1, "Samara Morgan", people, movies)
associate_person("The Ring", "Amber Tamblyn", 1, "Katie Embry", people, movies)
associate_person("The Ring", "Pauley Perrette", 1, "Beth", people, movies)
associate_person("The Ring", "Sara Rue", 1, "Babysitter", people, movies)
associate_person("The Ring", "Lindsay Frost", 1, "Ruth Embry", people, movies)
associate_person("The Ring", "Jane Alexander", 1, "Dr. Grasnik", people, movies)

# --- Insidious ---
associate_person("Insidious", "Patrick Wilson", 1, "Josh Lambert", people, movies)
associate_person("Insidious", "Rose Byrne", 1, "Renai Lambert", people, movies)
associate_person("Insidious", "Lin Shaye", 1, "Elise Rainier", people, movies)
associate_person("Insidious", "Joseph Bishara", 1, "Lipstick-Face Demon", people, movies)
associate_person("Insidious", "Ty Simpkins", 1, "Dalton Lambert", people, movies)
associate_person("Insidious", "Barbara Hershey", 1, "Lorraine Lambert", people, movies)
associate_person("Insidious", "Leigh Whannell", 1, "Specs", people, movies)
associate_person("Insidious", "Angus Sampson", 1, "Tucker", people, movies)
associate_person("Insidious", "Andrew Astor", 1, "Foster Lambert", people, movies)
associate_person("Insidious", "Emily Brobst", 1, "Demon (uncredited)", people, movies)

# --- 21 Jump Street ---
associate_person("21 Jump Street", "Jonah Hill", 1, "Schmidt", people, movies)
associate_person("21 Jump Street", "Channing Tatum", 1, "Jenko", people, movies)
associate_person("21 Jump Street", "Ice Cube", 1, "Captain Dickson", people, movies)
associate_person("21 Jump Street", "Brie Larson", 1, "Molly Tracey", people, movies)
associate_person("21 Jump Street", "Dave Franco", 1, "Eric Molson", people, movies)
associate_person("21 Jump Street", "Johnny Depp", 1, "Officer Tom Hanson (uncredited)", people, movies)
associate_person("21 Jump Street", "Ellie Kemper", 1, "Ms. Griggs", people, movies)
associate_person("21 Jump Street", "Dakota Johnson", 1, "Fugazy", people, movies)
associate_person("21 Jump Street", "Nick Offerman", 1, "Deputy Chief Hardy", people, movies)
associate_person("21 Jump Street", "Johnny Pemberton", 1, "Delroy", people, movies)

# --- Fight Club ---
associate_person("Fight Club", "Edward Norton", 1, "Narrator", people, movies)
associate_person("Fight Club", "Brad Pitt", 1, "Tyler Durden", people, movies)
associate_person("Fight Club", "Helena Bonham Carter", 1, "Marla Singer", people, movies)
associate_person("Fight Club", "Jared Leto", 1, "Angel Face", people, movies)
associate_person("Fight Club", "Holt McCallany", 1, "The Mechanic", people, movies)
associate_person("Fight Club", "Eion Bailey", 1, "Ricky", people, movies)
associate_person("Fight Club", "Zach Grenier", 1, "Richard Chesler (Regional Manager)", people, movies)
associate_person("Fight Club", "Meat Loaf", 1, "Robert Paulson", people, movies)
associate_person("Fight Club", "Brian Tochi", 1, "Fight Bully (uncredited)", people, movies)
associate_person("Fight Club", "Michael Shamus Wiles", 1, "Bartender in Halo", people, movies)


# --- Ice Age ---
associate_person("Ice Age", "Ray Romano", 1, "Manny (voice)", people, movies)
associate_person("Ice Age", "John Leguizamo", 1, "Sid (voice)", people, movies)
associate_person("Ice Age", "Denis Leary", 1, "Diego (voice)", people, movies)
associate_person("Ice Age", "Alan Tudyk", 1, "Lenny (voice)", people, movies)
associate_person("Ice Age", "Stephen Root", 1, "Aardvark Dad (voice)", people, movies)
associate_person("Ice Age", "Laraine Newman", 1, "Additional Voices (voice)", people, movies)
associate_person("Ice Age", "Ariel Winter", 1, "Additional Voices (voice)", people, movies)


# --- Jurassic Park ---
associate_person("Jurassic Park", "Sam Neill", 1, "Dr. Alan Grant", people, movies)
associate_person("Jurassic Park", "Laura Dern", 1, "Dr. Ellie Sattler", people, movies)
associate_person("Jurassic Park", "Jeff Goldblum", 1, "Dr. Ian Malcolm", people, movies)
associate_person("Jurassic Park", "Richard Attenborough", 1, "John Hammond", people, movies)
associate_person("Jurassic Park", "Samuel L. Jackson", 1, "Ray Arnold", people, movies)
associate_person("Jurassic Park", "Wayne Knight", 1, "Dennis Nedry", people, movies)
associate_person("Jurassic Park", "Joseph Mazzello", 1, "Tim Murphy", people, movies)
associate_person("Jurassic Park", "BD Wong", 1, "Dr. Henry Wu", people, movies)
associate_person("Jurassic Park", "Ariana Richards", 1, "Lex Murphy", people, movies)
associate_person("Jurassic Park", "Miguel Sandoval", 1, "Rostagno", people, movies)

# --- Inside Out ---
associate_person("Inside Out", "Amy Poehler", 1, "Joy (voice)", people, movies)
associate_person("Inside Out", "Bill Hader", 1, "Fear (voice)", people, movies)
associate_person("Inside Out", "Mindy Kaling", 1, "Disgust (voice)", people, movies)
associate_person("Inside Out", "Richard Kind", 1, "Bing Bong (voice)", people, movies)
associate_person("Inside Out", "Diane Lane", 1, "Mom (voice)", people, movies)
associate_person("Inside Out", "Kyle MacLachlan", 1, "Dad (voice)", people, movies)
associate_person("Inside Out", "Rashida Jones", 1, "Cool Girl's Emotions (voice)", people, movies)
associate_person("Inside Out", "John Ratzenberger", 1, "Fritz (voice)", people, movies)
associate_person("Inside Out", "Laraine Newman", 1, "Additional Voices (voice)", people, movies)
associate_person("Inside Out", "Carlos Alazraqui", 1, "Helicopter Pilot (voice)", people, movies)

# --- Joker ---
associate_person("Joker", "Joaquin Phoenix", 1, "Arthur Fleck", people, movies)
associate_person("Joker", "Robert De Niro", 1, "Murray Franklin", people, movies)
associate_person("Joker", "Zazie Beetz", 1, "Sophie Dumond", people, movies)
associate_person("Joker", "Frances Conroy", 1, "Penny Fleck", people, movies)
associate_person("Joker", "Bill Camp", 1, "Detective Garrity", people, movies)
associate_person("Joker", "Shea Whigham", 1, "Detective Burke", people, movies)
associate_person("Joker", "Brian Tyree Henry", 1, "Carl", people, movies)
associate_person("Joker", "Justin Theroux", 1, "Ethan Chase (uncredited)", people, movies)
associate_person("Joker", "Isabella Ferreira", 1, "Flirting Woman on the Bus (uncredited)", people, movies)
associate_person("Joker", "Hannah Gross", 1, "Young Penny", people, movies)


# --- The Hunger Games ---
associate_person("The Hunger Games", "Jennifer Lawrence", 1, "Katniss Everdeen", people, movies)
associate_person("The Hunger Games", "Josh Hutcherson", 1, "Peeta Mellark", people, movies)
associate_person("The Hunger Games", "Woody Harrelson", 1, "Haymitch Abernathy", people, movies)
associate_person("The Hunger Games", "Elizabeth Banks", 1, "Effie Trinket", people, movies)
associate_person("The Hunger Games", "Stanley Tucci", 1, "Caesar Flickerman", people, movies)
associate_person("The Hunger Games", "Toby Jones", 1, "Claudius Templesmith", people, movies)
associate_person("The Hunger Games", "Jack Quaid", 1, "Marvel", people, movies)


# --- The Lord of the Rings: The Fellowship of the Ring ---
associate_person("The Lord of the Rings: The Fellowship of the Ring", "Elijah Wood", 1, "Frodo", people, movies)
associate_person("The Lord of the Rings: The Fellowship of the Ring", "Ian McKellen", 1, "Gandalf", people, movies)
associate_person("The Lord of the Rings: The Fellowship of the Ring", "Viggo Mortensen", 1, "Aragorn", people, movies)
associate_person("The Lord of the Rings: The Fellowship of the Ring", "Sean Astin", 1, "Sam", people, movies)
associate_person("The Lord of the Rings: The Fellowship of the Ring", "Sean Bean", 1, "Boromir", people, movies)
associate_person("The Lord of the Rings: The Fellowship of the Ring", "Orlando Bloom", 1, "Legolas", people, movies)
associate_person("The Lord of the Rings: The Fellowship of the Ring", "John Rhys-Davies", 1, "Gimli", people, movies)
associate_person("The Lord of the Rings: The Fellowship of the Ring", "Cate Blanchett", 1, "Galadriel", people, movies)
associate_person("The Lord of the Rings: The Fellowship of the Ring", "Andy Serkis", 1, "Gollum", people, movies)
associate_person("The Lord of the Rings: The Fellowship of the Ring", "Peter Jackson", 1, "Albert Dreary / Painting of Bungo Baggins (uncredited)", people, movies)

puts "MoviePerson associations created (FINAL)."
puts "Seeding complete!"





Person.create!([
  # The Shawshank Redemption
  {
    name: "Frank Darabont",  # director
    profession: "director",
    gender: true,
    date_of_birth: "1959-01-28",
    place_of_birth: "Montbéliard, France",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Stephen King",    # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1947-09-21",
    place_of_birth: "Portland, Maine, USA",
    credits: 200,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "David Valdes",    # producer
    profession: "producer",
    gender: true,
    date_of_birth: "1950-01-01",
    place_of_birth: "USA",
    credits: 25,
    image_filename: "crew.jpg",
    biography: ""
  },

  # The Godfather
  {
    name: "Francis Ford Coppola",  # director
    profession: "director",
    gender: true,
    date_of_birth: "1939-04-07",
    place_of_birth: "Detroit, Michigan, USA",
    credits: 35,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Mario Puzo",            # writer & novel
    profession: "writer",
    gender: true,
    date_of_birth: "1920-10-15",
    place_of_birth: "New York City, USA",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Fred Roos",             # producer
    profession: "producer",
    gender: true,
    date_of_birth: "1934-05-22",
    place_of_birth: "Santa Monica, California, USA",
    credits: 30,
    image_filename: "crew.jpg",
    biography: ""
  },

  # The Dark Knight
  {
    name: "Christopher Nolan",     # director
    profession: "director",
    gender: true,
    date_of_birth: "1970-07-30",
    place_of_birth: "London, England, UK",
    credits: 12,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Jonathan Nolan",        # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1976-06-06",
    place_of_birth: "London, England, UK",
    credits: 8,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "David S. Goyer",        # story
    profession: "writer",
    gender: true,
    date_of_birth: "1965-12-22",
    place_of_birth: "Ann Arbor, Michigan, USA",
    credits: 25,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Inception
  {
    name: "Wally Pfister",         # cinematographer
    profession: "cinematographer",
    gender: true,
    date_of_birth: "1961-07-08",
    place_of_birth: "Chicago, Illinois, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },

  # The Matrix
  {
    name: "Lana Wachowski",        # director
    profession: "director",
    gender: false,
    date_of_birth: "1965-06-21",
    place_of_birth: "Chicago, Illinois, USA",
    credits: 8,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Lilly Wachowski",       # director
    profession: "director",
    gender: false,
    date_of_birth: "1967-12-29",
    place_of_birth: "Chicago, Illinois, USA",
    credits: 8,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Zak Penn",              # screenplay
    profession: "writer",
    gender: true,
    date_of_birth: "1968-03-28",
    place_of_birth: "New York City, USA",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  }
])


Person.create!([
  # GoodFellas
  {
    name: "Martin Scorsese",       # director
    profession: "director",
    gender: true,
    date_of_birth: "1942-11-17",
    place_of_birth: "Queens, New York City, USA",
    credits: 45,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Nicholas Pileggi",      # writer & novel
    profession: "writer",
    gender: true,
    date_of_birth: "1933-02-22",
    place_of_birth: "New York City, USA",
    credits: 12,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Irwin Winkler",         # producer (third person)
    profession: "producer",
    gender: true,
    date_of_birth: "1931-05-28",
    place_of_birth: "New York City, USA",
    credits: 50,
    image_filename: "crew.jpg",
    biography: ""
  },

  # The Others
  {
    name: "Alejandro Amenábar",    # director & writer
    profession: "director",
    gender: true,
    date_of_birth: "1972-03-31",
    place_of_birth: "Santiago, Chile",
    credits: 8,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Fernando Bovaira",      # producer
    profession: "producer",
    gender: true,
    date_of_birth: "1963-01-01",
    place_of_birth: "Spain",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Javier Aguirresarobe",  # cinematographer
    profession: "cinematographer",
    gender: true,
    date_of_birth: "1948-10-10",
    place_of_birth: "Eibar, Spain",
    credits: 30,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Rush Hour
  {
    name: "Brett Ratner",          # director
    profession: "director",
    gender: true,
    date_of_birth: "1969-03-28",
    place_of_birth: "Miami Beach, Florida, USA",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Jim Kouf",              # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1951-07-24",
    place_of_birth: "Los Angeles, California, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Ross LaManna",          # story
    profession: "writer",
    gender: true,
    date_of_birth: "1960-01-01",
    place_of_birth: "USA",
    credits: 5,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Home Alone
  {
    name: "Chris Columbus",        # director
    profession: "director",
    gender: true,
    date_of_birth: "1958-09-10",
    place_of_birth: "Spangler, Pennsylvania, USA",
    credits: 25,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "John Hughes",           # writer & screenplay
    profession: "writer",
    gender: true,
    date_of_birth: "1950-02-18",
    place_of_birth: "Lansing, Michigan, USA",
    credits: 30,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Tarquin Gotch",         # producer
    profession: "producer",
    gender: true,
    date_of_birth: "1948-01-01",
    place_of_birth: "United Kingdom",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },

  # The Mask
  {
    name: "Chuck Russell",         # director
    profession: "director",
    gender: true,
    date_of_birth: "1958-05-09",
    place_of_birth: "Park Ridge, Illinois, USA",
    credits: 12,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Mike Werb",             # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1963-01-01",
    place_of_birth: "USA",
    credits: 8,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Michael Fallon",        # story
    profession: "writer",
    gender: true,
    date_of_birth: "1960-01-01",
    place_of_birth: "USA",
    credits: 5,
    image_filename: "crew.jpg",
    biography: ""
  }
])


Person.create!([
  # The Conjuring
  {
    name: "James Wan",             # director
    profession: "director",
    gender: true,
    date_of_birth: "1977-02-26",
    place_of_birth: "Kuching, Malaysia",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Chad Hayes",            # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1961-04-21",
    place_of_birth: "Portland, Oregon, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Carey Hayes",           # screenplay
    profession: "writer",
    gender: true,
    date_of_birth: "1961-04-21",
    place_of_birth: "Portland, Oregon, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },

  # John Wick
  {
    name: "Chad Stahelski",        # director
    profession: "director",
    gender: true,
    date_of_birth: "1968-09-20",
    place_of_birth: "Palmer, Massachusetts, USA",
    credits: 8,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Derek Kolstad",         # writer & story
    profession: "writer",
    gender: true,
    date_of_birth: "1974-04-01",
    place_of_birth: "Madison, Wisconsin, USA",
    credits: 6,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Basil Iwanyk",          # producer
    profession: "producer",
    gender: true,
    date_of_birth: "1970-01-01",
    place_of_birth: "USA",
    credits: 30,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Interstellar
  {
    name: "Emma Thomas",           # producer
    profession: "producer",
    gender: false,
    date_of_birth: "1971-12-09",
    place_of_birth: "London, England, UK",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Dune
  {
    name: "Denis Villeneuve",      # director
    profession: "director",
    gender: true,
    date_of_birth: "1967-10-03",
    place_of_birth: "Trois-Rivières, Québec, Canada",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Frank Herbert",         # writer & novel
    profession: "writer",
    gender: true,
    date_of_birth: "1920-10-08",
    place_of_birth: "Tacoma, Washington, USA",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Eric Roth",            # screenplay
    profession: "writer",
    gender: true,
    date_of_birth: "1945-03-22",
    place_of_birth: "New York City, USA",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Avatar
  {
    name: "James Cameron",         # director & writer
    profession: "director",
    gender: true,
    date_of_birth: "1954-08-16",
    place_of_birth: "Kapuskasing, Ontario, Canada",
    credits: 25,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Jon Landau",           # producer
    profession: "producer",
    gender: true,
    date_of_birth: "1960-07-23",
    place_of_birth: "New York City, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Rick Carter",          # production designer
    profession: "production designer",
    gender: true,
    date_of_birth: "1950-01-01",
    place_of_birth: "USA",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  }
])


Person.create!([
  # Edge of Tomorrow
  {
    name: "Doug Liman",            # director
    profession: "director",
    gender: true,
    date_of_birth: "1965-07-24",
    place_of_birth: "New York City, USA",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Christopher McQuarrie",  # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1968-10-25",
    place_of_birth: "Princeton, New Jersey, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Hiroshi Sakurazaka",    # novel
    profession: "writer",
    gender: true,
    date_of_birth: "1970-01-01",
    place_of_birth: "Japan",
    credits: 5,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Oppenheimer
  {
    name: "Kai Bird",              # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1951-09-04",
    place_of_birth: "Eugene, Oregon, USA",
    credits: 5,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Martin Sherwin",        # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1937-07-02",
    place_of_birth: "Brooklyn, New York, USA",
    credits: 3,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Spider-Man: No Way Home
  {
    name: "Jon Watts",             # director
    profession: "director",
    gender: true,
    date_of_birth: "1981-06-28",
    place_of_birth: "Fountain, Colorado, USA",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Chris McKenna",         # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1970-01-01",
    place_of_birth: "USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Stan Lee",             # characters
    profession: "writer",
    gender: true,
    date_of_birth: "1922-12-28",
    place_of_birth: "New York City, USA",
    credits: 200,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Fast Five
  {
    name: "Justin Lin",           # director
    profession: "director",
    gender: true,
    date_of_birth: "1971-10-11",
    place_of_birth: "Taipei, Taiwan",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Chris Morgan",         # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1966-01-01",
    place_of_birth: "USA",
    credits: 12,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Gary Scott Thompson",  # characters
    profession: "writer",
    gender: true,
    date_of_birth: "1959-10-07",
    place_of_birth: "Ukiah, California, USA",
    credits: 8,
    image_filename: "crew.jpg",
    biography: ""
  },

  # The Departed
  {
    name: "William Monahan",      # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1960-11-03",
    place_of_birth: "Boston, Massachusetts, USA",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Alan Mak",            # story
    profession: "writer",
    gender: true,
    date_of_birth: "1965-01-01",
    place_of_birth: "Hong Kong",
    credits: 8,
    image_filename: "crew.jpg",
    biography: ""
  }
])


Person.create!([
  # Heat
  {
    name: "Michael Mann",          # director & writer
    profession: "director",
    gender: true,
    date_of_birth: "1943-02-05",
    place_of_birth: "Chicago, Illinois, USA",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Dante Spinotti",        # cinematographer
    profession: "cinematographer",
    gender: true,
    date_of_birth: "1943-08-22",
    place_of_birth: "Tolmezzo, Italy",
    credits: 25,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Art Linson",            # producer
    profession: "producer",
    gender: true,
    date_of_birth: "1942-03-16",
    place_of_birth: "Chicago, Illinois, USA",
    credits: 30,
    image_filename: "crew.jpg",
    biography: ""
  },

  # A Quiet Place
  {
    name: "John Krasinski",        # director
    profession: "director",
    gender: true,
    date_of_birth: "1979-10-20",
    place_of_birth: "Boston, Massachusetts, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Bryan Woods",           # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1984-09-14",
    place_of_birth: "USA",
    credits: 5,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Scott Beck",            # story
    profession: "writer",
    gender: true,
    date_of_birth: "1984-10-22",
    place_of_birth: "USA",
    credits: 5,
    image_filename: "crew.jpg",
    biography: ""
  },

  # The Ring
  {
    name: "Gore Verbinski",        # director
    profession: "director",
    gender: true,
    date_of_birth: "1964-03-16",
    place_of_birth: "Oak Ridge, Tennessee, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Ehren Kruger",          # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1972-10-05",
    place_of_birth: "Alexandria, Virginia, USA",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Koji Suzuki",           # novel
    profession: "writer",
    gender: true,
    date_of_birth: "1957-05-13",
    place_of_birth: "Hamamatsu, Japan",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Leigh Whannell",        # writer & story
    profession: "writer",
    gender: true,
    date_of_birth: "1977-01-17",
    place_of_birth: "Melbourne, Australia",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Oren Peli",             # producer
    profession: "producer",
    gender: true,
    date_of_birth: "1970-01-21",
    place_of_birth: "Ramat Gan, Israel",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  }
])


Person.create!([
  # 21 Jump Street
  {
    name: "Phil Lord",             # director
    profession: "director",
    gender: true,
    date_of_birth: "1975-07-12",
    place_of_birth: "Miami, Florida, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Chris Miller",          # director
    profession: "director",
    gender: true,
    date_of_birth: "1975-09-23",
    place_of_birth: "Everett, Washington, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Michael Bacall",        # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1973-04-19",
    place_of_birth: "Los Angeles, California, USA",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Fight Club
  {
    name: "David Fincher",         # director
    profession: "director",
    gender: true,
    date_of_birth: "1962-08-28",
    place_of_birth: "Denver, Colorado, USA",
    credits: 25,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Chuck Palahniuk",       # writer & novel
    profession: "writer",
    gender: true,
    date_of_birth: "1962-02-21",
    place_of_birth: "Pasco, Washington, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Jim Uhls",              # screenplay
    profession: "writer",
    gender: true,
    date_of_birth: "1957-01-01",
    place_of_birth: "Missouri, USA",
    credits: 8,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Ice Age
  {
    name: "Chris Wedge",           # director
    profession: "director",
    gender: true,
    date_of_birth: "1957-03-20",
    place_of_birth: "Binghamton, New York, USA",
    credits: 12,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Michael J. Wilson",     # writer
    profession: "writer",
    gender: true,
    date_of_birth: "1964-01-01",
    place_of_birth: "USA",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Michael Berg",          # screenplay
    profession: "writer",
    gender: true,
    date_of_birth: "1963-01-01",
    place_of_birth: "USA",
    credits: 8,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Jurassic Park
  {
    name: "Steven Spielberg",      # director
    profession: "director",
    gender: true,
    date_of_birth: "1946-12-18",
    place_of_birth: "Cincinnati, Ohio, USA",
    credits: 50,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Michael Crichton",      # writer & novel
    profession: "writer",
    gender: true,
    date_of_birth: "1942-10-23",
    place_of_birth: "Chicago, Illinois, USA",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "David Koepp",           # screenplay
    profession: "writer",
    gender: true,
    date_of_birth: "1963-06-09",
    place_of_birth: "Pewaukee, Wisconsin, USA",
    credits: 30,
    image_filename: "crew.jpg",
    biography: ""
  }
])


Person.create!([
  # Inside Out
  {
    name: "Pete Docter",           # director & writer
    profession: "director",
    gender: true,
    date_of_birth: "1968-10-09",
    place_of_birth: "Bloomington, Minnesota, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Ronnie del Carmen",     # story
    profession: "writer",
    gender: true,
    date_of_birth: "1959-12-31",
    place_of_birth: "Philippines",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Jonas Rivera",          # producer
    profession: "producer",
    gender: true,
    date_of_birth: "1971-01-02",
    place_of_birth: "San Francisco, California, USA",
    credits: 12,
    image_filename: "crew.jpg",
    biography: ""
  },

  # Joker
  {
    name: "Todd Phillips",         # director & writer
    profession: "director",
    gender: true,
    date_of_birth: "1970-12-20",
    place_of_birth: "Brooklyn, New York City, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Scott Silver",          # screenplay
    profession: "writer",
    gender: true,
    date_of_birth: "1964-01-01",
    place_of_birth: "USA",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Bob Kane",              # characters
    profession: "writer",
    gender: true,
    date_of_birth: "1915-10-24",
    place_of_birth: "New York City, USA",
    credits: 100,
    image_filename: "crew.jpg",
    biography: ""
  },

  # The Hunger Games
  {
    name: "Gary Ross",             # director
    profession: "director",
    gender: true,
    date_of_birth: "1956-11-03",
    place_of_birth: "Los Angeles, California, USA",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Suzanne Collins",       # writer & novel
    profession: "writer",
    gender: false,
    date_of_birth: "1962-08-10",
    place_of_birth: "Hartford, Connecticut, USA",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Billy Ray",             # screenplay
    profession: "writer",
    gender: true,
    date_of_birth: "1960-01-01",
    place_of_birth: "USA",
    credits: 20,
    image_filename: "crew.jpg",
    biography: ""
  },

  # The Lord of the Rings: The Fellowship of the Ring
  {
    name: "Peter Jackson",         # director
    profession: "director",
    gender: true,
    date_of_birth: "1961-10-31",
    place_of_birth: "Pukerua Bay, New Zealand",
    credits: 25,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "J.R.R. Tolkien",        # writer & novel
    profession: "writer",
    gender: true,
    date_of_birth: "1892-01-03",
    place_of_birth: "Bloemfontein, South Africa",
    credits: 10,
    image_filename: "crew.jpg",
    biography: ""
  },
  {
    name: "Fran Walsh",            # screenplay
    profession: "writer",
    gender: false,
    date_of_birth: "1959-01-10",
    place_of_birth: "Wellington, New Zealand",
    credits: 15,
    image_filename: "crew.jpg",
    biography: ""
  }
])










people = Person.all.index_by(&:name)

# Movie associations - First batch
MoviePerson.create!([
  # The Shawshank Redemption (id: 1)
  {
    movie_id: 1,
    person_id: people["Frank Darabont"].id,
    role_id: 2  # director
  },
  {
    movie_id: 1,
    person_id: people["Stephen King"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 1,
    person_id: people["David Valdes"].id,
    role_id: 4  # screenplay
  },

  # The Godfather (id: 2)
  {
    movie_id: 2,
    person_id: people["Francis Ford Coppola"].id,
    role_id: 2  # director
  },
  {
    movie_id: 2,
    person_id: people["Mario Puzo"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 2,
    person_id: people["Mario Puzo"].id,
    role_id: 6  # novel
  },
  {
    movie_id: 2,
    person_id: people["Fred Roos"].id,
    role_id: 4  # screenplay
  },

  # The Dark Knight (id: 3)
  {
    movie_id: 3,
    person_id: people["Christopher Nolan"].id,
    role_id: 2  # director
  },
  {
    movie_id: 3,
    person_id: people["Jonathan Nolan"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 3,
    person_id: people["David S. Goyer"].id,
    role_id: 5  # story
  },

  # Inception (id: 4)
  {
    movie_id: 4,
    person_id: people["Christopher Nolan"].id,
    role_id: 2  # director
  },
  {
    movie_id: 4,
    person_id: people["Christopher Nolan"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 4,
    person_id: people["Wally Pfister"].id,
    role_id: 4  # screenplay
  },

  # The Matrix (id: 5)
  {
    movie_id: 5,
    person_id: people["Lana Wachowski"].id,
    role_id: 2  # director
  },
  {
    movie_id: 5,
    person_id: people["Lilly Wachowski"].id,
    role_id: 2  # director
  },
  {
    movie_id: 5,
    person_id: people["Zak Penn"].id,
    role_id: 4  # screenplay
  },

  # GoodFellas (id: 6)
  {
    movie_id: 6,
    person_id: people["Martin Scorsese"].id,
    role_id: 2  # director
  },
  {
    movie_id: 6,
    person_id: people["Nicholas Pileggi"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 6,
    person_id: people["Nicholas Pileggi"].id,
    role_id: 6  # novel
  },
  {
    movie_id: 6,
    person_id: people["Irwin Winkler"].id,
    role_id: 4  # screenplay
  }
])


MoviePerson.create!([
  # The Others (id: 7)
  {
    movie_id: 7,
    person_id: people["Alejandro Amenábar"].id,
    role_id: 2  # director
  },
  {
    movie_id: 7,
    person_id: people["Alejandro Amenábar"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 7,
    person_id: people["Fernando Bovaira"].id,
    role_id: 4  # screenplay
  },
  {
    movie_id: 7,
    person_id: people["Javier Aguirresarobe"].id,
    role_id: 5  # story
  },

  # Rush Hour (id: 8)
  {
    movie_id: 8,
    person_id: people["Brett Ratner"].id,
    role_id: 2  # director
  },
  {
    movie_id: 8,
    person_id: people["Jim Kouf"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 8,
    person_id: people["Ross LaManna"].id,
    role_id: 5  # story
  },

  # Home Alone (id: 9)
  {
    movie_id: 9,
    person_id: people["Chris Columbus"].id,
    role_id: 2  # director
  },
  {
    movie_id: 9,
    person_id: people["John Hughes"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 9,
    person_id: people["John Hughes"].id,
    role_id: 4  # screenplay
  },
  {
    movie_id: 9,
    person_id: people["Tarquin Gotch"].id,
    role_id: 5  # story
  },

  # The Mask (id: 10)
  {
    movie_id: 10,
    person_id: people["Chuck Russell"].id,
    role_id: 2  # director
  },
  {
    movie_id: 10,
    person_id: people["Mike Werb"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 10,
    person_id: people["Michael Fallon"].id,
    role_id: 5  # story
  },

  # The Conjuring (id: 11)
  {
    movie_id: 11,
    person_id: people["James Wan"].id,
    role_id: 2  # director
  },
  {
    movie_id: 11,
    person_id: people["Chad Hayes"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 11,
    person_id: people["Carey Hayes"].id,
    role_id: 4  # screenplay
  },

  # John Wick (id: 12)
  {
    movie_id: 12,
    person_id: people["Chad Stahelski"].id,
    role_id: 2  # director
  },
  {
    movie_id: 12,
    person_id: people["Derek Kolstad"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 12,
    person_id: people["Basil Iwanyk"].id,
    role_id: 4  # screenplay
  }
])




# Continuing with the cached people hash
MoviePerson.create!([
  # Interstellar (id: 13)
  {
    movie_id: 13,
    person_id: people["Christopher Nolan"].id,
    role_id: 2  # director
  },
  {
    movie_id: 13,
    person_id: people["Jonathan Nolan"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 13,
    person_id: people["Emma Thomas"].id,
    role_id: 4  # screenplay
  },

  # Dune (id: 14)
  {
    movie_id: 14,
    person_id: people["Denis Villeneuve"].id,
    role_id: 2  # director
  },
  {
    movie_id: 14,
    person_id: people["Frank Herbert"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 14,
    person_id: people["Eric Roth"].id,
    role_id: 4  # screenplay
  },

  # Avatar (id: 15)
  {
    movie_id: 15,
    person_id: people["James Cameron"].id,
    role_id: 2  # director
  },
  {
    movie_id: 15,
    person_id: people["James Cameron"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 15,
    person_id: people["Jon Landau"].id,
    role_id: 4  # screenplay
  },
  {
    movie_id: 15,
    person_id: people["Rick Carter"].id,
    role_id: 5  # story
  },

  # Edge of Tomorrow (id: 16)
  {
    movie_id: 16,
    person_id: people["Doug Liman"].id,
    role_id: 2  # director
  },
  {
    movie_id: 16,
    person_id: people["Christopher McQuarrie"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 16,
    person_id: people["Hiroshi Sakurazaka"].id,
    role_id: 6  # novel
  },

  # Oppenheimer (id: 17)
  {
    movie_id: 17,
    person_id: people["Christopher Nolan"].id,
    role_id: 2  # director
  },
  {
    movie_id: 17,
    person_id: people["Kai Bird"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 17,
    person_id: people["Martin Sherwin"].id,
    role_id: 4  # screenplay
  },

  # Spider-Man: No Way Home (id: 18)
  {
    movie_id: 18,
    person_id: people["Jon Watts"].id,
    role_id: 2  # director
  },
  {
    movie_id: 18,
    person_id: people["Chris McKenna"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 18,
    person_id: people["Stan Lee"].id,
    role_id: 7  # characters
  }
])



# Continuing with the cached people hash
MoviePerson.create!([
  # Fast Five (id: 19)
  {
    movie_id: 19,
    person_id: people["Justin Lin"].id,
    role_id: 2  # director
  },
  {
    movie_id: 19,
    person_id: people["Chris Morgan"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 19,
    person_id: people["Gary Scott Thompson"].id,
    role_id: 7  # characters
  },

  # The Departed (id: 20)
  {
    movie_id: 20,
    person_id: people["Martin Scorsese"].id,
    role_id: 2  # director
  },
  {
    movie_id: 20,
    person_id: people["William Monahan"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 20,
    person_id: people["Alan Mak"].id,
    role_id: 5  # story
  },

  # Heat (id: 21)
  {
    movie_id: 21,
    person_id: people["Michael Mann"].id,
    role_id: 2  # director
  },
  {
    movie_id: 21,
    person_id: people["Michael Mann"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 21,
    person_id: people["Dante Spinotti"].id,
    role_id: 4  # screenplay
  },
  {
    movie_id: 21,
    person_id: people["Art Linson"].id,
    role_id: 5  # story
  },

  # Casino (id: 22)
  {
    movie_id: 22,
    person_id: people["Martin Scorsese"].id,
    role_id: 2  # director
  },
  {
    movie_id: 22,
    person_id: people["Nicholas Pileggi"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 22,
    person_id: people["Nicholas Pileggi"].id,
    role_id: 6  # novel
  },

  # A Quiet Place (id: 23)
  {
    movie_id: 23,
    person_id: people["John Krasinski"].id,
    role_id: 2  # director
  },
  {
    movie_id: 23,
    person_id: people["Bryan Woods"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 23,
    person_id: people["Scott Beck"].id,
    role_id: 5  # story
  },

  # The Ring (id: 24)
  {
    movie_id: 24,
    person_id: people["Gore Verbinski"].id,
    role_id: 2  # director
  },
  {
    movie_id: 24,
    person_id: people["Ehren Kruger"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 24,
    person_id: people["Koji Suzuki"].id,
    role_id: 6  # novel
  }
])



# Continuing with the cached people hash
MoviePerson.create!([
  # Insidious (id: 25)
  {
    movie_id: 25,
    person_id: people["James Wan"].id,
    role_id: 2  # director
  },
  {
    movie_id: 25,
    person_id: people["Leigh Whannell"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 25,
    person_id: people["Oren Peli"].id,
    role_id: 4  # screenplay
  },

  # 21 Jump Street (id: 26)
  {
    movie_id: 26,
    person_id: people["Phil Lord"].id,
    role_id: 2  # director
  },
  {
    movie_id: 26,
    person_id: people["Chris Miller"].id,
    role_id: 2  # director
  },
  {
    movie_id: 26,
    person_id: people["Michael Bacall"].id,
    role_id: 3  # writer
  },

  # Fight Club (id: 27)
  {
    movie_id: 27,
    person_id: people["David Fincher"].id,
    role_id: 2  # director
  },
  {
    movie_id: 27,
    person_id: people["Chuck Palahniuk"].id,
    role_id: 6  # novel
  },
  {
    movie_id: 27,
    person_id: people["Jim Uhls"].id,
    role_id: 4  # screenplay
  },

  # Ice Age (id: 28)
  {
    movie_id: 28,
    person_id: people["Chris Wedge"].id,
    role_id: 2  # director
  },
  {
    movie_id: 28,
    person_id: people["Michael J. Wilson"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 28,
    person_id: people["Michael Berg"].id,
    role_id: 4  # screenplay
  },

  # Jurassic Park (id: 29)
  {
    movie_id: 29,
    person_id: people["Steven Spielberg"].id,
    role_id: 2  # director
  },
  {
    movie_id: 29,
    person_id: people["Michael Crichton"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 29,
    person_id: people["David Koepp"].id,
    role_id: 4  # screenplay
  },

  # Inside Out (id: 30)
  {
    movie_id: 30,
    person_id: people["Pete Docter"].id,
    role_id: 2  # director
  },
  {
    movie_id: 30,
    person_id: people["Pete Docter"].id,
    role_id: 3  # writer
  },
  {
    movie_id: 30,
    person_id: people["Ronnie del Carmen"].id,
    role_id: 5  # story
  },
  {
    movie_id: 30,
    person_id: people["Jonas Rivera"].id,
    role_id: 4  # screenplay
  },

  # Joker (id: 31)
  {
    movie_id: 31,
    person_id: people["Todd Phillips"].id,
    role_id: 2  # director
  },
  {
    movie_id: 31,
    person_id: people["Scott Silver"].id,
    role_id: 4  # screenplay
  },
  {
    movie_id: 31,
    person_id: people["Bob Kane"].id,
    role_id: 7  # characters
  },

  # The Hunger Games (id: 32)
  {
    movie_id: 32,
    person_id: people["Gary Ross"].id,
    role_id: 2  # director
  },
  {
    movie_id: 32,
    person_id: people["Suzanne Collins"].id,
    role_id: 6  # novel
  },
  {
    movie_id: 32,
    person_id: people["Billy Ray"].id,
    role_id: 4  # screenplay
  },

  # The Lord of the Rings: The Fellowship of the Ring (id: 33)
  {
    movie_id: 33,
    person_id: people["Peter Jackson"].id,
    role_id: 2  # director
  },
  {
    movie_id: 33,
    person_id: people["J.R.R. Tolkien"].id,
    role_id: 6  # novel
  },
  {
    movie_id: 33,
    person_id: people["Fran Walsh"].id,
    role_id: 4  # screenplay
  }
])



# Categories

categories = [
  'action', 'adventure', 'animation', 'comedy', 'crime', 'documentary', 'drama',
  'family', 'fantasy', 'history', 'horror', 'music', 'mystery', 'romance',
  'science fiction', 'thriller', 'war', 'western'
]

categories.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end


# Associate movies with their categories
movies_and_categories = {
  'The Shawshank Redemption' => ['drama', 'crime'],
  'The Godfather' => ['crime', 'drama'],
  'The Dark Knight' => ['action', 'crime', 'drama', 'thriller'],
  'Inception' => ['science fiction', 'action', 'thriller', 'adventure'],
  'The Matrix' => ['science fiction', 'action'],
  'GoodFellas' => ['crime', 'drama'],
  'The Others' => ['horror', 'thriller', 'mystery'],
  'Rush Hour' => ['action', 'comedy', 'crime'],
  'Home Alone' => ['comedy', 'family'],
  'The Mask' => ['comedy', 'fantasy'],
  'The Conjuring' => ['horror', 'thriller', 'mystery'],
  'John Wick' => ['action', 'thriller', 'crime'],
  'Interstellar' => ['science fiction', 'drama', 'adventure'],
  'Dune' => ['science fiction', 'adventure'],
  'Avatar' => ['science fiction', 'adventure', 'action'],
  'Edge of Tomorrow' => ['science fiction', 'action', 'adventure'],
  'Oppenheimer' => ['drama', 'history', 'thriller', 'biography'],
  'Spider-Man: No Way Home' => ['action', 'adventure', 'fantasy', 'science fiction'],
  'Fast Five' => ['action', 'crime', 'thriller'],
  'The Departed' => ['crime', 'drama', 'thriller'],
  'Heat' => ['crime', 'drama', 'thriller', 'action'],
  'Casino' => ['crime', 'drama'],
  'A Quiet Place' => ['horror', 'science fiction', 'thriller'],
  'The Ring' => ['horror', 'mystery', 'thriller'],
  'Insidious' => ['horror', 'mystery', 'thriller'],
  '21 Jump Street' => ['action', 'comedy', 'crime'],
  'Fight Club' => ['drama', 'thriller'],
  'Ice Age' => ['animation', 'comedy', 'family', 'adventure'],
  'Jurassic Park' => ['adventure', 'science fiction', 'thriller'],
  'Inside Out' => ['animation', 'comedy', 'drama', 'family'],
  'Joker' => ['crime', 'drama', 'thriller'],
  'The Hunger Games' => ['action', 'adventure', 'science fiction'],
  'The Lord of the Rings: The Fellowship of the Ring' => ['adventure', 'fantasy'],
}


movies_and_categories.each do |movie_title, category_names|
  movie = Movie.find_by!(title: movie_title)
  movie.categories << Category.where(name: category_names)
end




# Keywords
keywords = [
  # Location keywords
  'new york city', 'los angeles', 'small town', 'prison', 'space', 'desert', 'underwater',
  'island', 'las vegas', 'future', 'dystopia', 'rural', 'urban', 'mansion', 'haunted house',

  # Character/relationship keywords
  'loss of loved one', 'revenge', 'friendship', 'betrayal', 'family', 'redemption', 'sacrifice',
  'survival', 'coming of age', 'love', 'rivalry', 'mentor', 'father son relationship',

  # Action/plot keywords
  'showdown', 'heist', 'chase', 'escape', 'investigation', 'conspiracy', 'war', 'battle',
  'fight', 'race against time', 'mission', 'journey', 'quest', 'transformation',

  # Character types
  'secret identity', 'hero', 'villain', 'vigilante', 'gangster', 'cop', 'criminal',
  'soldier', 'scientist', 'genius', 'outcast', 'rebel', 'assassin', 'spy',

  # Supernatural/sci-fi elements
  'magic', 'dangerous', 'portal', 'time travel', 'alien', 'monster', 'ghost', 'demon',
  'possession', 'supernatural', 'technology', 'artificial intelligence', 'robot',

  # Film elements
  'sequel', 'twist ending', 'nonlinear', 'based on novel', 'based on true story',
  'aftercreditsstinger', 'duringcreditsstinger', 'suspense', 'psychological',

  # Superhero specific
  'superhero', 'superhero team', 'alternate reality', 'masked vigilante', 'spider web',
  'marvel cinematic universe (mcu)', 'teenage hero', 'fight for justice', 'superhero teamup',
  'returning hero', 'crossover', 'teamwork'
]

keywords.each do |keyword|
  Keyword.create!(name: keyword)
end

# Associate movies with keywords
movie_keywords = {
  'The Godfather' => ['family', 'gangster', 'betrayal', 'revenge', 'power'],
  'The Dark Knight' => ['batman', 'joker', 'vigilante', 'gotham city', 'moral dilemma'],
  'Inception' => ['dream', 'heist', 'mind', 'nonlinear', 'psychological'],
  'The Matrix' => ['virtual reality', 'artificial intelligence', 'chosen one', 'martial arts', 'dystopia'],
  'GoodFellas' => ['gangster', 'crime', 'new york city', 'based on true story', 'rise and fall'],
  'The Others' => ['haunted house', 'twist ending', 'ghost', 'isolation', 'psychological'],
  'Rush Hour' => ['cop', 'buddy cop', 'martial arts', 'culture clash', 'kidnapping'],
  'Home Alone' => ['christmas', 'family', 'booby traps', 'burglary', 'coming of age'],
  'The Mask' => ['transformation', 'secret identity', 'supernatural', 'bank robbery', 'comedy'],
  'The Conjuring' => ['haunted house', 'ghost', 'demon', 'possession', 'based on true story'],
  'John Wick' => ['revenge', 'assassin', 'criminal underworld', 'gun fu', 'dog'],
  'Interstellar' => ['space', 'time travel', 'father daughter relationship', 'survival', 'wormhole'],
  'Dune' => ['desert', 'space', 'politics', 'prophecy', 'spice'],
  'Avatar' => ['alien planet', 'environment', 'military', 'native culture', 'technology'],
  'Edge of Tomorrow' => ['time loop', 'alien invasion', 'soldier', 'training', 'sacrifice'],
  'Oppenheimer' => ['atomic bomb', 'scientist', 'world war ii', 'based on true story', 'moral dilemma'],
  'Spider-Man: No Way Home' => ['multiverse', 'secret identity', 'teenage hero', 'marvel cinematic universe (mcu)', 'crossover'],
  'Fast Five' => ['heist', 'car chase', 'teamwork', 'family', 'revenge'],
  'The Departed' => ['undercover', 'cop', 'gangster', 'betrayal', 'boston'],
  'Heat' => ['heist', 'cop', 'criminal', 'los angeles', 'showdown'],
  'Casino' => ['las vegas', 'gangster', 'greed', 'rise and fall', 'based on true story'],
  'A Quiet Place' => ['survival', 'family', 'monster', 'silence', 'post-apocalyptic'],
  'The Ring' => ['curse', 'investigation', 'supernatural', 'videotape', 'ghost'],
  'Insidious' => ['demon', 'possession', 'astral projection', 'haunting', 'family'],
  '21 Jump Street' => ['undercover', 'high school', 'buddy cop', 'comedy', 'drugs'],
  'Fight Club' => ['split personality', 'underground fighting', 'consumerism', 'twist ending', 'anarchy'],
  'Ice Age' => ['prehistoric', 'friendship', 'journey', 'survival', 'animals'],
  'Jurassic Park' => ['dinosaurs', 'theme park', 'science gone wrong', 'survival', 'genetic engineering'],
  'Inside Out' => ['emotions', 'growing up', 'mind', 'family', 'memory'],
  'Joker' => ['mental illness', 'origin story', 'social commentary', 'transformation', 'gotham city'],
  'The Hunger Games' => ['dystopia', 'survival', 'competition', 'rebellion', 'sacrifice'],
  'The Lord of the Rings: The Fellowship of the Ring' => ['quest', 'fantasy', 'friendship', 'good vs evil', 'journey']
}

# Associate movies with their keywords
movie_keywords.each do |movie_title, keyword_list|
  movie = Movie.find_by!(title: movie_title)
  keyword_list.each do |keyword_name|
    keyword = Keyword.find_or_create_by!(name: keyword_name)
    MovieKeyword.create!(movie: movie, keyword: keyword)
  end
end



# Reviews
def create_reviews_for_movie(movie_id, long_review, short_reviews)
  long_review_user_id = (movie_id % 10 == 0) ? 10 : movie_id % 10

  Review.create!(
    user_id: long_review_user_id,
    movie_id: movie_id,
    content: long_review
  )

  short_reviews.each_with_index do |review, index|
    short_review_user_id = ((long_review_user_id + index + 1) % 10 == 0) ? 10 : (long_review_user_id + index + 1) % 10

    Review.create!(
      user_id: short_review_user_id,
      movie_id: movie_id,
      content: review
    )
  end
end

# The Shawshank Redemption (ID: 1)
create_reviews_for_movie(
  1,
  %{The Shawshank Redemption is a masterpiece of storytelling that transcends the prison drama genre. Frank Darabont's direction is impeccable, creating a world that feels both claustrophobic and expansive.
Morgan Freeman delivers one of his most iconic performances as Red, the man who knows how to get things, while Tim Robbins brings a quiet dignity to Andy Dufresne that makes his journey all the more powerful.
The film's exploration of hope in the face of unimaginable adversity resonates on a deeply human level. Each frame is meticulously crafted, with Roger Deakins' cinematography turning the grim prison into a canvas for human emotion.
What makes Shawshank truly special is how it balances darkness with light, never allowing the brutality of prison life to overshadow the fundamental message about the resilience of the human spirit.
Thomas Newman's score perfectly complements the emotional beats of the story, swelling at just the right moments without ever feeling manipulative.
The supporting cast, including Bob Gunton as the villainous Warden Norton, creates a rich tapestry of prison life that feels authentic and lived-in.
The film's pacing is deliberate, allowing the 20-year story to unfold naturally while maintaining narrative momentum throughout.
Perhaps most remarkably, The Shawshank Redemption improves with each viewing, revealing new layers and details that enhance the overall experience.
The friendship between Andy and Red forms the emotional core of the film, demonstrating how human connection can survive and even thrive in the most inhospitable environments.
In the end, The Shawshank Redemption isn't just a great prison movie—it's a timeless meditation on hope, friendship, and redemption that continues to inspire audiences decades after its release.},
  [
    %{The Shawshank Redemption remains the greatest film ever made about hope. Morgan Freeman's narration alone is worth the price of admission.},
    %{Tim Robbins and Morgan Freeman deliver career-defining performances in this prison drama. The ending still gives me goosebumps every time I watch it.},
    %{This film proves that sometimes the best adaptations take liberties with the source material. Stephen King's novella is good, but Darabont's film is transcendent.},
    %{The scene where Andy plays opera over the prison loudspeakers is one of the most beautiful moments in cinema. Pure magic on screen.}
  ]
)

# The Godfather (ID: 2)
create_reviews_for_movie(
  2,
  %{The Godfather stands as the definitive American crime epic, a perfect fusion of commercial entertainment and high art that changed cinema forever. Francis Ford Coppola's direction is nothing short of masterful, turning Mario Puzo's pulpy novel into a profound meditation on family, power, and the American Dream.
Marlon Brando's performance as Don Vito Corleone is rightfully legendary, creating an indelible character whose quiet authority and moral complexity continue to fascinate. Al Pacino's transformation from reluctant outsider to ruthless crime lord provides the film's tragic emotional arc.
Gordon Willis's cinematography, with its amber hues and shadow-filled frames, creates a visual language that has influenced generations of filmmakers. The famous opening sequence alone is a masterclass in establishing tone, character, and thematic depth.
Nino Rota's haunting score has become inseparable from the film itself, its melancholy waltz capturing both the romance and the tragedy of the Corleone saga.
The supporting cast, including James Caan, Robert Duvall, and Diane Keaton, brings richness and dimension to every scene, creating a world that feels completely authentic despite its operatic scale.
The film's exploration of immigrant experience and assimilation gives it historical weight beyond its crime story, examining how outsiders navigate and ultimately transform American society.
Coppola's decision to set much of the film in dimly lit interiors creates an intimate atmosphere that makes the bursts of violence all the more shocking and impactful.
The parallel editing of the baptism scene with the execution of the Corleone enemies remains one of the most powerful sequences in film history, a perfect marriage of form and content.
The Godfather's influence on popular culture cannot be overstated, from its quotable dialogue to its visual style to its thematic concerns, it has become part of our collective consciousness.
What's most remarkable about The Godfather is how it balances its epic scope with intimate human drama, creating a film that feels both monumental and deeply personal—a true American masterpiece.},
  [
    %{Brando's performance as Don Corleone defined an entire generation of acting. The film's exploration of family loyalty remains unmatched in cinema.},
    %{The Godfather is perfect filmmaking—every frame, every performance, every musical cue serves the story. It's the standard by which all crime dramas are judged.},
    %{The transformation of Michael Corleone is one of cinema's great character arcs. Pacino's performance is a masterclass in subtle evolution.},
    %{Gordon Willis deserved an Oscar for his revolutionary cinematography. The wedding sequence alone demonstrates his genius for composition and lighting.},
    %{The film's examination of power and corruption transcends its gangster setting. It's really about the dark side of the American Dream.}
  ]
)


# Goodfellas (ID: 6)
create_reviews_for_movie(
  6,
  %{Goodfellas represents Martin Scorsese at the height of his powers, delivering a kinetic, visceral gangster film that redefined the genre. Based on Nicholas Pileggi's book "Wiseguy," the film plunges viewers into the seductive yet ultimately destructive world of organized crime with unparalleled energy and style.
Ray Liotta gives the performance of his career as Henry Hill, whose journey from wide-eyed teenager to paranoid cocaine addict forms the narrative spine of the film. Robert De Niro and Joe Pesci (who won an Oscar) create unforgettable characters whose unpredictable violence lurks beneath a veneer of camaraderie.
Thelma Schoonmaker's editing is nothing short of revolutionary, particularly in the famous Copacabana tracking shot and the cocaine-fueled paranoia of the film's final act. The way she cuts to the rhythm of the soundtrack creates a propulsive momentum that never lets up.
Speaking of the soundtrack, Scorsese's use of period-specific pop music isn't just background—it's an essential storytelling device that comments on the action and establishes both time and emotional tone.
The film's unflinching portrayal of mob violence strips away any romantic notions about gangster life, showing the brutal reality behind the expensive suits and nightclub tables. Yet it also understands the allure of that lifestyle, particularly in a working-class neighborhood with limited options.
Lorraine Bracco brings crucial dimension to the story as Karen Hill, offering an outsider's perspective on this closed male world while becoming increasingly complicit in its operations.
Michael Ballhaus's cinematography captures both the glamour and the grime of Henry's world, from the warm glow of the Copacabana to the harsh fluorescent lights of the diner where Henry realizes his life is over.
The film's narrative structure, with its voiceover and non-linear elements, influenced countless films that followed, demonstrating how to make exposition dynamic and engaging rather than merely informative.
What separates Goodfellas from lesser gangster films is its anthropological detail—the specific food, clothes, social rituals, and hierarchies that make this world feel authentic and lived-in.
Ultimately, Goodfellas is a morality tale about the price of the American Dream when pursued through criminal means, showing how Henry's initial excitement curdles into paranoia, addiction, and betrayal—a cautionary tale told with unmatched cinematic bravura.},
  [
    %{Scorsese's Goodfellas captures the adrenaline rush of criminal life like no other film. The Copacabana tracking shot alone is worth the price of admission.},
    %{Joe Pesci's Tommy DeVito is one of cinema's most terrifying characters. "Funny how?" remains one of the most tension-filled scenes ever filmed.},
    %{The use of music in Goodfellas revolutionized film soundtracks. Each song perfectly captures the mood and era of the corresponding scene.},
    %{Ray Liotta never got enough credit for his performance as Henry Hill. His descent from confident gangster to paranoid informant is masterfully portrayed.}
  ]
)

# Heat (ID: 21)
create_reviews_for_movie(
  21,
  %{Michael Mann's Heat is the definitive cat-and-mouse crime thriller, elevating the genre through its meticulous attention to detail and philosophical depth. The film's epic scope encompasses not just the central heist narrative but the entire ecosystem of Los Angeles crime and law enforcement.
The legendary coffee shop scene between Al Pacino and Robert De Niro—their first on-screen meeting despite both appearing in The Godfather Part II—lives up to its reputation, a masterclass in restrained acting where what's not said is as important as what is.
Mann's signature visual style—cool blues, urban landscapes, and precise compositions—creates a Los Angeles that feels both realistic and dreamlike, a modern cityscape of glass, steel, and concrete where isolated souls briefly connect.
The film's sound design, particularly in the downtown shootout sequence, set new standards for cinematic realism. The absence of a musical score during this scene, allowing the echoing gunfire to reverberate through the concrete canyon, creates an immersive experience rarely matched in action cinema.
What distinguishes Heat from lesser crime films is its willingness to give equal weight to the personal lives of both criminal and cop, showing how their professional obsessions destroy their personal connections despite their surface differences.
The supporting cast, including Val Kilmer, Jon Voight, Tom Sizemore, and Ashley Judd, creates a rich tapestry of characters whose stories could each sustain their own film, adding depth to the central narrative.
Dante Spinotti's cinematography captures Los Angeles as both sprawling metropolis and intimate battleground, using the city's unique light to create a world that feels both expansive and claustrophobic.
The film's pacing is masterful, allowing quiet character moments to breathe while building tension toward its explosive set pieces, creating a rhythm that keeps the three-hour runtime feeling essential rather than indulgent.
Heat's influence on both crime films and video games cannot be overstated, with its realistic portrayal of tactical movement, firearms handling, and heist logistics becoming the template for countless works that followed.
Ultimately, what makes Heat a masterpiece is how it balances its technical virtuosity with genuine emotional resonance, creating characters whose code-driven lives lead to inevitable tragedy despite their self-awareness—a modern crime epic with the weight of classical drama.},
  [
    %{The downtown shootout scene changed action cinema forever with its realistic sound design and tactical accuracy. Mann's attention to detail elevates the entire genre.},
    %{Pacino and De Niro's coffee shop scene is a masterclass in understated acting. Two titans at the top of their game, saying as much with their eyes as with their words.},
    %{Heat understands that the best crime dramas are character studies at heart. The parallel lives of Vincent Hanna and Neil McCauley make this more than just a cops-and-robbers story.}
  ]
)

# Casino (ID: 22)
create_reviews_for_movie(
  22,
  %{Martin Scorsese's Casino is a dazzling, brutal examination of Las Vegas during its transition from mob-run playground to corporate enterprise. Though often compared to Goodfellas, Casino stands on its own as a more operatic, almost Shakespearean tragedy about ambition, greed, and betrayal.
Robert De Niro delivers one of his most controlled performances as Sam "Ace" Rothstein, bringing meticulous precision to a character whose attention to detail is both his greatest strength and ultimate downfall. His narration guides us through the labyrinthine world of casino operations with insider authority.
Sharon Stone gives the performance of her career as Ginger McKenna, a survivor whose addiction to money, drugs, and toxic relationships creates a destructive vortex that threatens everyone in her orbit. Her Oscar-nominated role brings crucial emotional volatility to the film.
Joe Pesci's Nicky Santoro represents violence unleashed, a necessary evil for the mob's Vegas operation who eventually becomes a liability when his impulse control fails. Pesci creates a character whose charm makes his brutality all the more shocking.
The film's costume design by John Dunn and Rita Ryack deserves special mention, with De Niro wearing over 70 different outfits, each color-coordinated with his surroundings and reflecting Rothstein's controlling personality.
Scorsese and editor Thelma Schoonmaker create a visual language that mirrors the excessive nature of Vegas itself—split screens, freeze frames, multiple voiceovers, and rapid cuts that convey both information and emotional states with breathtaking efficiency.
The soundtrack, featuring over 40 popular songs, acts as both period marker and ironic commentary, with tracks like "House of the Rising Sun" underscoring the film's themes of temptation and destruction.
Robert Richardson's cinematography captures both the gaudy glamour of the casino floor and the harsh reality of the Nevada desert where bodies are buried, creating a visual dichotomy that reinforces the film's themes.
What makes Casino particularly fascinating is its documentary-like attention to the details of skimming operations, counting rooms, and the day-to-day mechanics of running a casino, giving viewers unprecedented insight into this closed world.
Ultimately, Casino is a film about the end of an era, chronicling how personal weaknesses and institutional corruption destroyed a criminal paradise, replaced by the corporate gambling culture that dominates Las Vegas today—a requiem for a violent but captivating period of American history.},
  [
    %{Sharon Stone's performance as Ginger is one of cinema's great portrayals of addiction and desperation. She should have won the Oscar that year.},
    %{The scene where the bosses meet in the back room of the Midwest grocery store perfectly captures the banality behind organized crime. Scorsese understands these men aren't glamorous—they're businessmen.},
    %{The narration technique with both De Niro and Pesci explaining their world makes Casino feel like a documentary from hell. You learn how Vegas worked while watching it implode.},
    %{The costume design in Casino tells its own story—De Niro's meticulously coordinated outfits versus Pesci's increasingly flashy attire visually represents their diverging paths.}
  ]
)

# The Conjuring (ID: 11)
create_reviews_for_movie(
  11,
  %{James Wan's The Conjuring revitalized the haunted house genre by combining old-school craftsmanship with modern sensibilities, proving that restraint can be more terrifying than excess. Based on the case files of paranormal investigators Ed and Lorraine Warren, the film builds dread methodically rather than relying on cheap jump scares.
Patrick Wilson and Vera Farmiga bring unexpected depth to Ed and Lorraine Warren, creating characters whose faith and compassion are as important as their paranormal expertise. Their loving relationship anchors the film emotionally, providing a counterpoint to the supernatural chaos.
The film's 1970s setting allows for both period authenticity and a return to practical effects and filmmaking techniques from horror's golden age. The absence of cell phones and internet also eliminates easy plot solutions that plague modern horror.
Wan's direction demonstrates a masterful understanding of screen geography, carefully establishing the layout of the farmhouse so that viewers always know where they are, making the supernatural intrusions all the more effective.
The "clap game" sequence represents horror filmmaking at its finest, building unbearable tension through sound design, camera movement, and performance rather than graphic violence or digital effects.
Lili Taylor and Ron Livingston as the Perron parents ground the supernatural elements in relatable family dynamics, making us care about their plight rather than simply waiting for the next scare.
Joseph Bishara's unsettling score enhances the atmosphere without telegraphing scares, complementing the film's visual design rather than compensating for its shortcomings.
The film's production design by Julie Berghoff creates a house that feels simultaneously authentic to its period and inherently unsettling, with spaces that become increasingly claustrophobic as the haunting intensifies.
What elevates The Conjuring above most modern horror films is its emotional core—the idea that love and faith can combat darkness gives the supernatural showdown genuine stakes beyond mere survival.
By treating its religious elements and demonology with sincerity rather than irony, The Conjuring taps into primal fears about evil that transcend cultural or religious backgrounds, creating a horror film that disturbs on a deeper level than mere shock.},
  [
    %{The Conjuring proves that modern horror can still be effective without relying on gore or cheap jump scares. James Wan's direction shows remarkable restraint and craftsmanship.},
    %{Vera Farmiga and Patrick Wilson bring unexpected emotional depth to roles that could have been one-dimensional ghost hunters. Their relationship forms the heart of the film.},
    %{The hide-and-clap game sequence is a masterclass in building tension through sound design and camera work. It's one of the most effective horror scenes of the past decade.},
    %{What makes The Conjuring special is how it balances supernatural scares with genuine human drama. You actually care about the Perron family's fate.},
    %{The film's period setting allows it to avoid the technological pitfalls of modern horror while paying homage to classics like The Exorcist and The Amityville Horror.}
  ]
)

# A Quiet Place (ID: 23)
create_reviews_for_movie(
  23,
  %{John Krasinski's A Quiet Place reinvents the monster movie through its ingenious use of sound design, creating a uniquely immersive horror experience where silence becomes a matter of life and death. The film's high-concept premise—creatures that hunt by sound—is executed with remarkable discipline and emotional intelligence.
Emily Blunt delivers an extraordinary performance, particularly in the bathtub birth scene, which ranks among the most tense sequences in modern horror. Her ability to convey both maternal strength and terror without dialogue is nothing short of remarkable.
The film's worldbuilding is efficient and effective, using visual storytelling to establish the rules of its post-apocalyptic setting without resorting to clunky exposition. Newspaper headlines, whiteboard notes, and modified daily routines tell us everything we need to know.
Krasinski's direction demonstrates a sophisticated understanding of tension and release, using the contrast between silence and sudden noise to maximum effect. The sound design becomes a narrative tool rather than merely a technical element.
At its core, A Quiet Place is as much a family drama as a horror film, exploring themes of parental guilt, responsibility, and sacrifice through its genre framework. The parents' determination to protect their children resonates beyond the monster-movie trappings.
The creature design deserves special mention, creating monsters that feel both biologically plausible and genuinely threatening. Their armored exteriors and hypersensitive hearing organs make them formidable antagonists that can't be easily defeated.
Marco Beltrami's sparse score complements the film's sound design, enhancing emotional moments without undermining the central conceit of silence as safety.
The cinematography by Charlotte Bruus Christensen captures both the beauty of the family's rural refuge and the constant danger lurking within it, using natural light to create a world that feels authentic despite its fantastical elements.
The performances of the child actors, particularly Millicent Simmonds as the deaf daughter Regan, bring crucial emotional dimensions to the story. Casting an actually deaf actress adds authenticity to both the character and the film's exploration of communication.
A Quiet Place succeeds where many high-concept horror films fail by making its central gimmick serve character and theme rather than the other way around, creating a film where the emotional stakes feel as important as the physical danger—a rare achievement in modern horror.},
  [
    %{Emily Blunt's bathtub scene should have earned her an Oscar nomination. Giving birth silently while a monster hunts nearby is the definition of horror acting excellence.},
    %{The sound design in A Quiet Place isn't just technically impressive—it's an essential storytelling tool that puts viewers in the characters' mindset. You'll find yourself afraid to make noise in the theater.},
    %{What makes A Quiet Place special is how it uses its monster movie premise to explore parental anxiety. At its heart, this is a film about the impossible task of keeping your children safe.},
    %{The moment when the father and daughter share the waterfall scene demonstrates the film's emotional intelligence. Amidst all the tension, it finds moments of genuine beauty and connection.}
  ]
)

# The Ring (ID: 24)
create_reviews_for_movie(
  24,
  %{Gore Verbinski's The Ring successfully transplanted Japanese horror sensibilities into an American context, creating a uniquely unsettling experience that prioritizes atmosphere over gore. As the first major J-horror remake to hit American shores, it introduced Western audiences to a different kind of horror storytelling.
Naomi Watts delivers a performance that elevates the material, bringing intelligence and emotional depth to what could have been a standard horror protagonist. Her journey from skeptical journalist to terrified believer grounds the supernatural elements in relatable human fear.
The film's visual palette, created by cinematographer Bojan Bazelli, uses a desaturated blue-green color scheme that has become influential across the horror genre. The constant rainfall and Pacific Northwest setting create a perpetual sense of gloom that mirrors the inescapable curse.
The cursed videotape itself is a masterpiece of surrealist imagery, creating a montage of disturbing visuals that feel like they've emerged from the collective unconscious. These images work on a primal level, disturbing viewers without explicit violence.
Hans Zimmer's score, with its discordant strings and unsettling motifs, enhances the film's atmosphere of dread without resorting to predictable horror music cues. The sound design, particularly the static of televisions and the ringing of phones, transforms everyday technology into harbingers of doom.
What makes The Ring particularly effective is how it builds its mythology gradually, allowing viewers to uncover the mystery alongside the protagonist. The investigative journalism framework gives narrative purpose to what might otherwise be standard horror exposition.
The film's iconic imagery—particularly Samara emerging from the television—has become part of our cultural lexicon, demonstrating how a well-executed horror set piece can transcend the genre and enter mainstream consciousness.
Verbinski's direction shows remarkable restraint, understanding that suggested horror is often more effective than explicit violence. The film's PG-13 rating forced creative solutions that ultimately made for a more psychologically affecting experience.
The Ring's exploration of technology as a vector for supernatural threat feels increasingly relevant in our media-saturated world. Its premise—that watching something can literally kill you—serves as a metaphor for media contagion that resonates beyond its immediate scares.
By focusing on a mother trying to protect her child, The Ring gives emotional stakes to what might otherwise be a standard ghost story, creating a horror film where the human relationships matter as much as the supernatural threat—a balance that many of its imitators failed to achieve.},
  [
    %{The cursed videotape sequence remains one of horror's most effective pieces of surrealist nightmare fuel. Those images burn themselves into your brain just like they do to the characters.},
    %{Naomi Watts brings surprising emotional depth to what could have been a standard horror protagonist. Her performance elevates the entire film.},
    %{The Ring's desaturated blue-green color palette influenced horror aesthetics for years to come. Verbinski and cinematographer Bojan Bazelli created a visual language of dread.}
  ]
)

# Insidious (ID: 25)
create_reviews_for_movie(
  25,
  %{James Wan's Insidious revitalized supernatural horror by proving that genuine scares don't require excessive gore or found footage gimmickry. Working with a modest budget, Wan created a haunted house film that feels both classically inspired and distinctly modern in its execution.
Patrick Wilson and Rose Byrne bring emotional authenticity to their roles as parents facing an inexplicable threat to their child. Their performances ground the increasingly fantastical elements in relatable parental fear and desperation.
The film's most impressive achievement is how it shifts gears halfway through, transforming from a standard haunted house movie into something far more imaginative with the introduction of The Further. This astral realm allows for a visual creativity that transcends the limitations of the suburban setting.
Joseph Bishara's score, with its screeching violins and discordant elements, creates an atmosphere of unrelenting dread that complements the visual scares. The main theme has become instantly recognizable within the horror community.
The design of the red-faced demon represents a perfect example of how practical effects and makeup can create more lasting horror than CGI. This antagonist has become iconic precisely because of its tactile, physical presence on screen.
Wan's direction demonstrates a sophisticated understanding of screen geography and tension building. His ability to make viewers fear what might be lurking just outside the frame shows a director in complete control of the horror toolkit.
The séance sequences, featuring Lin Shaye's psychic Elise Rainier, introduce a character who would become the heart of the franchise. Shaye brings gravitas and warmth to a role that could have been a mere plot device in lesser hands.
The film's use of "Tiptoe Through the Tulips" transforms an innocuous vintage song into something deeply unsettling, demonstrating how effective musical counterpoint can be in horror contexts.
What separates Insidious from many of its contemporaries is its willingness to fully embrace supernatural elements without irony or excessive explanation. By establishing its own internal logic and committing to it completely, the film creates a coherent nightmare world.
Despite its modest budget, Insidious achieves scares through creativity rather than compromise, proving that imagination and craftsmanship matter more than production value in horror—a lesson that influenced countless films that followed in its wake.},
  [
    %{The red-faced demon reveal remains one of the most effective jump scares in modern horror. James Wan understands that timing is everything when it comes to frightening an audience.},
    %{Lin Shaye's Elise Rainier brings unexpected heart to what could have been a standard psychic character. Her performance anchors the supernatural elements in human emotion.},
    %{The concept of The Further gives Insidious a visual playground beyond the standard haunted house formula. The astral realm sequences show remarkable creativity on a limited budget.},
    %{The use of "Tiptoe Through the Tulips" demonstrates how effective musical counterpoint can be in horror. That song will never sound innocent again after this film.}
  ]
)

# The Others (ID: 7)
create_reviews_for_movie(
  7,
  %{Alejandro Amenábar's The Others represents gothic horror at its most refined, creating an atmosphere of mounting dread through shadow, suggestion, and psychological complexity rather than explicit scares. Set in the immediate aftermath of World War II, the film uses its period setting to enhance its themes of isolation and denial.
Nicole Kidman delivers one of her finest performances as Grace Stewart, a tightly wound mother whose religious rigidity and overprotectiveness of her photosensitive children create a household already fraught with tension before supernatural elements emerge. Her gradual unraveling forms the emotional core of the film.
The cinematography by Javier Aguirresarobe uses natural light sources—candles, oil lamps, and filtered daylight—to create a visual language where darkness isn't just atmospheric but an essential plot element. The constant fog surrounding the house serves as both practical isolation and metaphorical limbo.
What distinguishes The Others from lesser ghost stories is its philosophical depth, exploring themes of faith, denial, and the human tendency to create narratives that protect us from unbearable truths. The film's religious imagery isn't merely decorative but integral to its exploration of guilt and redemption.
The supporting performances, particularly from Fionnula Flanagan as the enigmatic housekeeper Mrs. Mills, create a sense of unease through subtle performance choices rather than obvious menace. The children, played by Alakina Mann and James Bentley, avoid horror-child clichés while remaining genuinely unsettling.
Amenábar's direction demonstrates remarkable restraint, understanding that suggested horror resonates more deeply than explicit scares. His decision to use traditional filmmaking techniques rather than digital effects creates a timeless quality that enhances the period setting.
The film's sound design deserves special mention, using silence, whispers, and the house's creaks to create a sonic landscape where every noise carries potential significance. The absence of a bombastic score allows these subtle audio elements to create genuine unease.
The production design transforms the mansion into a character in its own right, with its labyrinthine rooms, shrouded furniture, and perpetually locked doors creating a physical manifestation of Grace's psychological state.
The film's famous twist ending works not merely as a shock but as the culmination of carefully laid thematic groundwork, recontextualizing everything that came before without invalidating the emotional journey.
The Others stands as a testament to how effective horror can be when it engages with deeper human fears—not just of supernatural threats but of what we might discover about ourselves when forced to confront reality. It's a ghost story that haunts not through momentary scares but through lingering existential questions.},
  [
    %{Nicole Kidman's performance as Grace Stewart ranks among her finest work. Her portrayal of maternal love twisted by fear and religious rigidity creates a character both sympathetic and disturbing.},
    %{The film's use of light and darkness isn't just atmospheric—it's essential to the plot and themes. Few horror films integrate their visual style so completely with their narrative.},
    %{The twist ending of The Others works because it's earned through careful storytelling rather than mere shock value. It recontextualizes the entire film without cheapening what came before.},
    %{Alejandro Amenábar's direction shows remarkable restraint, building dread through suggestion rather than explicit scares. The film proves that what you don't see can be far more terrifying than what you do.},
    %{The Others demonstrates how effective period settings can be for ghost stories, using post-WWII isolation to enhance its themes of denial and psychological fragility.}
  ]
)

# Rush Hour (ID: 8)
create_reviews_for_movie(
  8,
  %{Brett Ratner's Rush Hour revitalized the buddy cop genre by pairing Jackie Chan's physical comedy and martial arts prowess with Chris Tucker's rapid-fire verbal humor, creating a cross-cultural dynamic that transcended language barriers. The film's success proved that action-comedy could work with stars from vastly different performance traditions.
Jackie Chan's Hollywood breakthrough showcases his unique blend of death-defying stunts and comedic timing, introducing American audiences to a style of action filmmaking that prioritizes choreography and creativity over CGI and quick cuts. The sequence where he fights while trying to protect priceless artifacts demonstrates his genius for combining danger with humor.
Chris Tucker delivers a star-making performance as the fast-talking Detective Carter, his motormouth delivery and exaggerated reactions providing the perfect counterpoint to Chan's more reserved Detective Lee. Their contrasting communication styles drive much of the film's comedy.
The film's fish-out-of-water elements work in both directions, with Lee navigating American culture while Carter confronts his assumptions about Chinese customs and language. This mutual discomfort creates comedy that feels less mean-spirited than many culture-clash films.
Director Brett Ratner wisely gives Chan room to showcase his physical abilities, filming action sequences with wider shots and longer takes than was typical in American action films of the period. This approach highlights Chan's extraordinary talents rather than obscuring them through editing.
The plot, involving a kidnapped diplomat's daughter, provides sufficient stakes while never getting in the way of the central appeal—watching two charismatic performers from different worlds find common ground through their shared commitment to justice.
Lalo Schifrin's score pays homage to his own iconic work on the original Mission: Impossible while incorporating elements that complement both the action sequences and comedic moments, creating a sonic landscape that enhances the film's hybrid nature.
The chemistry between Chan and Tucker feels genuine despite their different performance backgrounds, with each star clearly enjoying the opportunity to work with someone bringing entirely different skills to the table. Their mutual respect translates to screen chemistry that carried the franchise through multiple sequels.
What distinguishes Rush Hour from lesser buddy cop films is how it uses its cross-cultural premise not just for easy jokes but to highlight the universal language of action cinema. When words fail, shared physical comedy and heroism bridge the gap.
Rush Hour's global success demonstrated Hollywood's potential for international appeal when embracing stars from different cultural backgrounds, paving the way for more diverse casting in mainstream action films. It remains a template for how to create action-comedy that works across cultural and linguistic boundaries.},
  [
    %{Jackie Chan's ability to turn everyday objects into weapons of both defense and comedy reaches its Hollywood peak in Rush Hour. The scene in the pool hall demonstrates his unique genius for choreographed chaos.},
    %{Chris Tucker's rapid-fire delivery provides the perfect counterpoint to Jackie Chan's physical comedy. Their contrasting styles create a buddy dynamic unlike any other in action cinema.},
    %{The "Do you understand the words coming out of my mouth?" line became iconic because it perfectly encapsulates the film's cross-cultural comedy. The language barrier becomes a source of both humor and eventual understanding.},
    %{Rush Hour works because it respects both stars' unique talents rather than forcing either into an uncomfortable mold. Chan gets his stunts, Tucker gets his riffs, and the audience gets the best of both worlds.},
    %{The film's blend of Hong Kong action choreography with American buddy cop tropes created something that felt fresh in 1998 and still entertains today. Few action comedies balance their elements so effectively.}
  ]
)

# Home Alone (ID: 9)
create_reviews_for_movie(
  9,
  %{Chris Columbus's Home Alone transformed a simple premise—a boy accidentally left behind during Christmas vacation—into a holiday classic that balances slapstick comedy, genuine emotion, and surprising depth. The film's enduring appeal lies in how it taps into universal childhood fantasies while acknowledging their underlying anxieties.
Macaulay Culkin delivers one of cinema's great child performances as Kevin McCallister, capturing both the glee of newfound independence and the vulnerability of abandonment. His ability to carry the film with both comedic timing and emotional authenticity established him as a legitimate star rather than merely a cute kid actor.
Joe Pesci and Daniel Stern create memorably bumbling villains as the "Wet Bandits," their physical comedy skills allowing them to endure increasingly elaborate punishments without losing their menacing edge. Their commitment to the slapstick elements elevates what could have been standard antagonist roles.
John Williams's score deserves special recognition for its ability to enhance both the film's Christmas atmosphere and its more adventurous sequences. The main theme captures the wonder and mischief at the heart of the story, becoming as iconic as the film itself.
The production design transforms the McCallister home into both a believable family space and an elaborate battleground, with each room offering distinct opportunities for Kevin's defensive innovations. The house becomes a character in its own right, its grandeur part of the film's aspirational appeal.
Director Chris Columbus balances the broader comedy with quieter moments of genuine emotion, particularly in Kevin's interactions with his elderly neighbor and his growing realization that freedom without family is ultimately hollow. These elements give the film a resonance beyond its pratfalls.
The home invasion sequence, with its elaborately choreographed traps and physical gags, represents family-friendly slapstick at its finest. The careful setup of each booby trap pays off with precision timing that recalls the best of silent comedy traditions.
Catherine O'Hara brings crucial emotional weight as Kevin's mother, her desperate journey home grounding the fantasy elements in parental love and responsibility. Her reunion with Kevin provides the emotional catharsis that gives meaning to the preceding adventures.
The film's Christmas setting isn't merely decorative but thematically essential, with the holiday's focus on family togetherness highlighting Kevin's isolation while providing the backdrop for his eventual reconciliation. The seasonal elements have helped make the film an annual tradition for many families.
Home Alone's cultural impact extends far beyond its box office success, with Kevin's hands-on-cheeks scream becoming an instantly recognizable image and the film itself a template for how family comedy can incorporate elements of adventure, emotion, and even light horror while remaining accessible to all ages.},
  [
    %{Macaulay Culkin's performance as Kevin McCallister remains the gold standard for child actors. His ability to be both believably vulnerable and mischievously resourceful carries the entire film.},
    %{The "Wet Bandits" represent perfect family-friendly villains—threatening enough to create stakes but bumbling enough that their comeuppance feels deserved rather than disturbing. Pesci and Stern commit fully to the physical comedy.},
    %{John Williams's score deserves recognition alongside his more famous work. The Home Alone theme captures both Christmas magic and childhood mischief in a way that's become inseparable from the holiday season.},
    %{The film's enduring appeal comes from how it balances wish fulfillment with emotional truth. Every kid dreams of freedom from parental oversight, but the film ultimately affirms the importance of family connection.}
  ]
)

# The Mask (ID: 10)
create_reviews_for_movie(
  10,
  %{Chuck Russell's The Mask harnesses Jim Carrey's manic physical comedy and groundbreaking CGI to create a live-action cartoon that remains visually impressive nearly three decades later. Based on the considerably darker comic series, the film transforms its source material into a vehicle perfectly suited to Carrey's unique talents.
Jim Carrey delivers a dual performance that showcases both his subtle comedic timing as the meek bank clerk Stanley Ipkiss and his uninhibited physical comedy as his green-faced alter ego. His rubbery facial expressions and hyperactive energy make the impossible seem plausible even before the special effects kick in.
The visual effects by Industrial Light & Magic represented a quantum leap forward in 1994, seamlessly blending practical makeup with computer-generated transformations that allowed Carrey's character to perform physically impossible feats inspired by Tex Avery cartoons. The wolf howl sequence alone demonstrates how effectively the film translates animated logic to live action.
Cameron Diaz makes a stunning debut as Tina Carlyle, bringing charm and dimension to what could have been a standard femme fatale role. Her chemistry with both versions of Carrey's character gives the romance unexpected credibility amidst the cartoon chaos.
The film's production design creates a world that exists somewhere between reality and comic book stylization, with exaggerated architecture and color schemes that prepare viewers for the more fantastical elements to come. The Coco Bongo club in particular establishes a heightened reality perfect for the Mask's performances.
Peter Riegert and Jim Doughan provide crucial grounding as the police detectives investigating the Mask's activities, their deadpan reactions to increasingly absurd situations creating a comedic counterpoint to Carrey's exuberance.
The soundtrack effectively blends period-appropriate swing music with contemporary pop, creating a timeless quality that enhances the film's cartoon logic. The "Cuban Pete" musical number demonstrates how successfully the film integrates song and dance into its comedy.
Peter Greene's Dorian makes for an effectively straightforward villain, his genuine menace providing necessary stakes without competing with the more colorful elements. His eventual transformation shows how the Mask amplifies the wearer's inner nature rather than simply granting powers.
What elevates The Mask above similar effects-driven comedies is its understanding of classic cartoon logic and rules. The film doesn't just use effects for their own sake but to translate a specific visual language from animation to live action, with all the physics-defying possibilities that entails.
The film's exploration of inhibition and identity—how the Mask doesn't create a new personality but unleashes what's already within—gives surprising depth to what could have been merely a special effects showcase. Stanley's journey toward self-confidence provides an emotional through-line that grounds the spectacular visuals.},
  [
    %{Jim Carrey's performance in The Mask represents the perfect marriage of actor and concept. His natural cartoonish energy made the impossible seem believable even before the special effects were added.},
    %{The visual effects in The Mask still impress nearly 30 years later because they serve the story and character rather than existing for their own sake. The film understood that CGI should enhance performance, not replace it.},
    %{Cameron Diaz's debut performance demonstrated her natural screen presence and perfect comic timing. Her ability to hold her own against Carrey's manic energy established her as a star immediately.},
    %{The film's translation of Tex Avery cartoon physics to live action created a visual language unlike anything audiences had seen before. The wolf howl sequence remains a perfect blend of performance and visual effects.}
  ]
)

# 21 Jump Street (ID: 26)
create_reviews_for_movie(
  26,
  %{Phil Lord and Christopher Miller's 21 Jump Street reinvented the TV adaptation by embracing self-awareness and meta-commentary while delivering genuine laughs and surprising emotional depth. Rather than treating its source material with reverence, the film uses it as a launching pad for commentary on generational shifts and the nature of reboots themselves.
Jonah Hill and Channing Tatum demonstrate unexpected chemistry as mismatched partners whose high school dynamics are reversed when they go undercover. Tatum in particular reveals previously untapped comedic talents, his deadpan delivery and physical comedy skills proving as impressive as his action credentials.
The film's understanding of how high school culture had evolved since the original show—with environmentalism and tolerance replacing traditional popularity hierarchies—provides both comedic fish-out-of-water moments and surprisingly insightful social commentary.
Directors Lord and Miller bring the same anarchic energy and visual invention that characterized their animated work, with kinetic camera movements and editing that enhance the comedy without becoming distracting. The split-screen drug sequence demonstrates their ability to visualize altered states in creative ways.
The supporting cast, particularly Ice Cube as the perpetually angry Captain Dickson and Rob Riggle as the unhinged Coach Walters, delivers memorable character work that elevates scenes that might otherwise serve merely as plot advancement.
The screenplay by Michael Bacall and Jonah Hill balances raunchy humor with genuine character development, allowing the central friendship to evolve naturally amidst the increasingly absurd situations. The emotional stakes feel earned rather than obligatory.
The action sequences, particularly the climactic chase, successfully parody action movie tropes while delivering legitimate excitement. The running gag about expected explosions that never materialize demonstrates the film's meta-awareness of genre conventions.
What distinguishes 21 Jump Street from lesser comedy remakes is its willingness to acknowledge and even celebrate its status as an unnecessary reboot. This self-awareness becomes a strength rather than a liability, allowing the film to comment on Hollywood's recycling tendencies while still delivering an entertaining experience.
The film's exploration of identity and reinvention—how returning to high school gives both protagonists a chance to redefine themselves—provides thematic depth beneath the crude humor and action set pieces. Both characters learn something genuine about themselves through their undercover experience.
The cameo appearances by original series stars Johnny Depp and Peter DeLuise represent perfect examples of how to honor source material without being constrained by it. Their appearances feel like a passing of the torch rather than mere nostalgia bait, consistent with the film's overall approach to its television origins.},
  [
    %{Channing Tatum's comedic talents were a revelation in 21 Jump Street. His willingness to poke fun at his own image while demonstrating perfect timing proved he was far more than just an action star.},
    %{The film's self-awareness about being an unnecessary reboot became its greatest strength. By acknowledging the absurdity of its own existence, it freed itself to become something genuinely fresh and surprising.},
    %{The chemistry between Hill and Tatum creates one of modern comedy's great partnerships. Their contrasting physical types and performance styles generate both laughs and unexpected emotional resonance.},
    %{Lord and Miller's direction brings visual invention to what could have been a standard buddy comedy. Their experience in animation translates to live action through creative visual gags and kinetic energy.},
    %{The film's observations about how high school culture evolves provide both comedy and surprising social commentary. Few mainstream comedies manage to be this insightful while remaining consistently hilarious.}
  ]
)




# John Wick (ID: 12)
create_reviews_for_movie(
  12,
  %{Chad Stahelski and David Leitch's John Wick revitalized the action genre by stripping away the shaky-cam aesthetics and rapid cutting that had dominated Hollywood, replacing them with clear, wide shots that showcase the physical prowess of their performers. This "gun fu" approach, influenced by Hong Kong action cinema, allows sequences to unfold with balletic precision rather than chaotic confusion.
Keanu Reeves delivers a career-defining performance as the titular assassin, his minimalist acting style perfectly suited to a character defined more by physical action than verbal expression. His commitment to extensive martial arts and firearms training is evident in every sequence, allowing for long, unbroken takes that would be impossible with a less prepared actor.
The film's world-building is remarkably efficient, establishing an entire underground society of assassins with its own rules, currency, and safe havens without resorting to clunky exposition. The Continental Hotel, with its strict "no business on the premises" policy, creates a fascinating neutral territory within this violent world.
What distinguishes John Wick from lesser revenge films is how it balances its spectacular action with genuine emotional stakes. By establishing Wick's grief for his wife and his connection to the puppy she left him before the violence begins, the film gives weight to what might otherwise be empty spectacle.
The action choreography, influenced by judo, Brazilian jiu-jitsu, and tactical gun handling, creates a distinctive fighting style that emphasizes efficiency and improvisation. Wick's ability to use whatever is at hand—whether pencil, book, or car—makes the combat sequences feel both surprising and believable despite their stylization.
The cinematography by Jonathan Sela uses neon-soaked color schemes and precise framing to create a heightened reality that feels both contemporary and timeless. The nightclub sequence in particular, with its blue and purple lighting, transforms violence into visual art without diminishing its impact.
The supporting cast, particularly Ian McShane as Winston and Lance Reddick as Charon, brings gravitas to what could have been stock roles, creating memorable characters with minimal screen time. Their matter-of-fact acceptance of this violent world helps establish its internal logic.
The film's pacing is masterful, starting with deliberate character establishment before gradually accelerating into increasingly elaborate action sequences. This structure gives emotional context to the violence while building toward spectacular set pieces that feel earned rather than gratuitous.
The production design creates a world that exists adjacent to our own, with specialized services, hidden entrances, and visual signifiers that suggest a long-established criminal ecosystem operating just beneath the surface of normal society. The gold coins, marker system, and High Table (explored further in sequels) suggest a rich mythology without overexplaining it.
John Wick's influence on action cinema cannot be overstated, with its clear visual approach to complex choreography, commitment to practical stunts, and world-building efficiency inspiring countless imitators. Yet few have matched its perfect balance of stylization and emotional grounding—the secret to its enduring appeal.},
  [
    %{Keanu Reeves' commitment to training for the role of John Wick allowed for action sequences with unprecedented clarity and continuity. His physical performance set a new standard for actor preparation in action films.},
    %{The world-building in John Wick is remarkably efficient, establishing an entire underground society of assassins through visual cues and minimal exposition. The Continental Hotel alone suggests a rich mythology.},
    %{The "gun fu" approach to action choreography, combining martial arts with tactical firearms handling, created a distinctive visual language that influenced countless films that followed. The nightclub sequence remains a masterclass in action clarity.},
    %{What elevates John Wick above standard revenge films is how it establishes emotional stakes before the violence begins. The connection to his deceased wife and the puppy she left him gives weight to the spectacular action that follows.}
  ]
)

# Inception (ID: 4)
create_reviews_for_movie(
  4,
  %{Christopher Nolan's Inception represents that rarest of Hollywood achievements—an original, high-concept blockbuster that challenges its audience intellectually while delivering spectacular visual set pieces. The film's exploration of dreams within dreams creates a narrative structure as intricate and precisely engineered as the worlds its characters construct.
Leonardo DiCaprio anchors the film with a performance of surprising emotional depth, his Cobb haunted by guilt and loss even as he navigates increasingly complex dreamscapes. His character's personal journey provides the emotional stakes that give meaning to the film's conceptual complexity.
The supporting cast creates distinctive characters whose specific skills and personalities are crucial to both the heist narrative and the thematic exploration of how we construct reality. Joseph Gordon-Levitt, Tom Hardy, Ellen Page, and Ken Watanabe in particular bring crucial dimensions to what could have been merely functional roles.
Hans Zimmer's score, with its iconic "BRAAAM" horn motif and slowed-down version of Édith Piaf's "Non, je ne regrette rien," becomes an integral part of the storytelling, signaling transitions between dream levels and creating mounting tension throughout the narrative.
The visual effects seamlessly blend practical elements with CGI enhancements, creating dreamscapes that feel simultaneously impossible and tangible. The folding Paris sequence and the rotating hotel corridor fight (achieved largely through practical means) remain standout moments of visual imagination.
Wally Pfister's cinematography distinguishes each dream level through distinct visual palettes, helping viewers maintain orientation within the complex narrative structure. The snow fortress sequence in particular, with its stark whites and blues, creates a visual counterpoint to the warmer tones of the other levels.
The film's exploration of how cinema itself creates shared dreams—with the dream architect as director, the dreamer as audience, and the subject as unwitting participant—adds a meta-textual layer that rewards repeated viewings and analysis without detracting from the immediate thrills.
The heist structure provides a familiar framework that helps ground the high-concept premise, giving viewers narrative handholds as they navigate the increasingly complex dream layers. This balance of the familiar and the innovative is key to the film's broad appeal despite its complexity.
The ambiguous ending, with its spinning top that may or may not topple, has generated endless debate precisely because the film has established that the question of what constitutes reality is more important than any definitive answer. It's a perfect conclusion to a film about the power of suggestion and the nature of perception.
Inception's influence on blockbuster filmmaking cannot be overstated, proving that audiences will embrace conceptual complexity when it's delivered with visual clarity and emotional resonance. It remains a testament to what's possible when a filmmaker with a singular vision is given the resources to realize it on the grandest scale.},
  [
    %{The rotating corridor fight scene represents one of cinema's great technical achievements, combining practical effects with precise choreography to create something genuinely innovative. Joseph Gordon-Levitt's physical performance is remarkable.},
    %{Hans Zimmer's score for Inception has become so influential that its "BRAAAM" sound has become shorthand for epic scale in countless trailers. The music isn't just accompaniment but an essential storytelling element.},
    %{The film's nested dream structure creates a perfect marriage of form and content, with the editing rhythms and visual cues helping viewers navigate what could have been hopelessly confusing in lesser hands. Nolan's clarity of vision is remarkable.},
    %{Leonardo DiCaprio brings surprising emotional depth to what could have been merely a cerebral exercise. His character's guilt and grief over his wife gives the high-concept premise genuine emotional stakes.},
    %{The ambiguous ending with the spinning top is perfect precisely because it forces viewers to confront the same questions about reality that have haunted the protagonist throughout. The cut to black is Nolan at his most playfully philosophical.}
  ]
)

# Interstellar (ID: 13)
create_reviews_for_movie(
  13,
  %{Christopher Nolan's Interstellar represents science fiction at its most ambitious, combining cutting-edge theoretical physics with profound emotional stakes to create a cosmic drama about humanity's future and the transcendent power of love. The film's scope is literally universal, yet its emotional core remains deeply personal.
Matthew McConaughey delivers a career-defining performance as Cooper, a pilot-turned-farmer whose love for his children drives the narrative even as he travels to the furthest reaches of space and time. His reaction to the messages from home after the time dilation on Miller's planet ranks among cinema's most emotionally devastating scenes.
The visual effects, particularly the depictions of the wormhole, black hole Gargantua, and the tesseract, represent scientific visualization at its finest, with Nolan consulting theoretical physicist Kip Thorne to ensure the astronomical phenomena were as accurate as current theory allows. The rendering of Gargantua in particular set new standards for scientific accuracy in film.
Hans Zimmer's organ-driven score creates a sonic landscape that feels simultaneously futuristic and ancient, the church organ's religious associations adding a spiritual dimension to the scientific journey. The music becomes an essential storytelling element, particularly in the docking sequence where it builds to an almost unbearable intensity.
Hoyte van Hoytema's cinematography captures both the intimate family drama on Earth and the vast emptiness of space with equal skill, using IMAX cameras to create a sense of scale that makes the cosmic elements feel genuinely overwhelming. The contrast between the dusty, dying Earth and the pristine emptiness of space creates a visual journey that mirrors the narrative.
The film's exploration of time as a physical dimension rather than merely a linear progression creates some of its most emotionally resonant moments, particularly Cooper's realization that he has become the "ghost" in his daughter's bedroom, communicating across time through gravity. This sequence transforms complex physics into profound human drama.
The supporting cast, particularly Jessica Chastain and Mackenzie Foy as the older and younger versions of Murphy, Anne Hathaway as Dr. Brand, and Michael Caine as Professor Brand, brings crucial emotional dimensions to the scientific concepts, ensuring that the human stakes remain central despite the cosmic scale.
The production design creates distinct environments for each planet—the endless ocean of Miller's world, the frozen clouds of Mann's planet—that serve both as spectacular visual showcases and as physical manifestations of the challenges facing humanity. Each location feels alien yet believable within the film's scientific framework.
Interstellar's exploration of love as a force that transcends dimensions represents its most controversial yet powerful theme, suggesting that human connection contains properties we don't yet understand scientifically. This willingness to place emotional truth alongside scientific accuracy gives the film its unique resonance.
What ultimately distinguishes Interstellar from lesser science fiction epics is how it balances its cosmic questions with intimate human drama, creating a film where discussions of relativity and gravitational equations carry emotional weight because of their impact on the characters we've come to care about. It's a film of both intellectual and emotional ambition, reaching for the stars while remaining grounded in human experience.},
  [
    %{Matthew McConaughey's performance in the video message scene after returning from Miller's planet represents some of the finest emotional acting in science fiction cinema. His reaction to watching his children grow up in minutes is devastating.},
    %{The visualization of the black hole Gargantua, created with guidance from physicist Kip Thorne, represents one of cinema's most scientifically accurate depictions of cosmic phenomena. The visual effects team created new rendering software just to achieve it.},
    %{Hans Zimmer's organ-driven score creates a perfect sonic landscape for the film, its religious overtones adding spiritual depth to the scientific journey. The music during the docking sequence creates almost unbearable tension.},
    %{The tesseract sequence transforms complex theoretical physics into visually comprehensible and emotionally resonant cinema. Cooper's realization that he has been his daughter's "ghost" all along is both scientifically fascinating and deeply moving.}
  ]
)

# The Matrix (ID: 5)
create_reviews_for_movie(
  5,
  %{The Wachowskis' The Matrix represents that rare cultural phenomenon that changes not just filmmaking but how we think about reality itself. Released at the cusp of the new millennium, the film perfectly captured turn-of-the-century anxieties about technology, control, and identity while revolutionizing action cinema through its groundbreaking visual effects.
Keanu Reeves' performance as Neo creates the perfect audience surrogate, his journey from confused programmer to messianic figure mirroring the viewer's gradual understanding of the film's complex world. His minimalist acting style, often criticized in other contexts, perfectly suits a character awakening to the artificial nature of his reality.
The film's visual innovations, particularly the "bullet time" effect that allowed the camera to appear to orbit a frozen moment, have been so thoroughly absorbed into popular culture that it's easy to forget how revolutionary they were in 1999. These techniques weren't merely spectacular but thematically essential, visualizing the manipulation of a digital reality.
The screenplay balances complex philosophical concepts with accessible action movie tropes, introducing audiences to ideas from simulation theory, Baudrillard's concepts of hyperreality, and religious messianic traditions while maintaining the forward momentum of a thriller. This blend of intellectual ambition and genre entertainment created a film that works on multiple levels simultaneously.
Laurence Fishburne brings gravitas and mystery to Morpheus, his resonant voice and commanding presence making the character's outlandish explanations feel believable. His delivery of the "red pill/blue pill" choice has become so iconic precisely because Fishburne makes the moment feel genuinely momentous.
The production design creates distinct visual languages for the Matrix and the real world, with the former's green-tinted digital unreality contrasting with the grim industrial aesthetics of the Nebuchadnezzar. These visual cues help orient viewers within the film's dual realities while reinforcing its thematic concerns.
The action choreography, influenced by Hong Kong cinema and wire-fu techniques, created a new visual language for Western action films. The decision to have the principal actors undergo extensive martial arts training allowed for longer takes and clearer visual storytelling during fight sequences.
Don Davis's score combines orchestral grandeur with electronic elements, creating a sonic landscape that bridges the digital and physical worlds of the narrative. The music enhances the film's sense of scale while reinforcing its themes of technology and transcendence.
Carrie-Anne Moss's Trinity provides both a formidable action presence and the emotional connection that ultimately completes Neo's journey. Her character avoids the typical limitations of female roles in action films of the period, serving as both guide and equal partner rather than merely love interest or damsel.
The Matrix's cultural impact extends far beyond cinema, influencing fashion, video games, philosophy courses, and even political discourse around technological control and reality perception. Few films have so thoroughly permeated popular consciousness, with concepts like "taking the red pill" becoming shorthand for awakening to hidden truths—a testament to the film's resonance beyond its spectacular surface.},
  [
    %{The "bullet time" effect in The Matrix didn't just look cool—it visualized the film's central concept of reality manipulation in a way audiences could instantly understand. Technical innovation in service of thematic depth is cinema at its best.},
    %{The Wachowskis' blend of philosophical concepts, religious symbolism, and Hong Kong action created something genuinely new in mainstream cinema. The film rewards both visceral and intellectual engagement.},
    %{Keanu Reeves found his perfect role in Neo, his often-criticized minimalist acting style perfectly suited to a character gradually awakening to the artificial nature of his reality. His physical commitment to the role set new standards for action stars.},
    %{The film's green-tinted visual palette has become so influential that it's easy to forget how distinctive it was in 1999. The clear visual separation between the Matrix and the real world helps orient viewers within the complex narrative.},
    %{The Matrix arrived at precisely the right cultural moment—the cusp of the new millennium, when anxieties about technology and reality were at their peak. Its questions about the nature of consciousness feel even more relevant in our increasingly virtual world.}
  ]
)

# Dune (ID: 14)
create_reviews_for_movie(
  14,
  %{Denis Villeneuve's Dune accomplishes what many considered impossible—translating Frank Herbert's dense, philosophical science fiction novel into a visually stunning epic that remains accessible without sacrificing the source material's complexity. By focusing on the first half of the book, Villeneuve gives the story room to breathe, allowing for both spectacular visuals and necessary character development.
The film's visual language creates a sense of scale rarely achieved in cinema, with Greig Fraser's cinematography emphasizing the vastness of Arrakis and the insignificance of human figures against its desert landscape. The contrast between the brutalist architecture of the Harkonnens, the organic curves of the Atreides homeworld, and the practical functionality of Fremen technology creates distinct cultural identities through visual design alone.
Timothée Chalamet brings both vulnerability and intensity to Paul Atreides, capturing the character's struggle between his humanity and his potentially terrible purpose. His performance suggests the internal conflict of a young man resisting yet gradually accepting a messianic role he neither fully understands nor desires.
The sound design and Hans Zimmer's score create an immersive audio experience that's as crucial to the worldbuilding as the visual elements. The throat-singing, processed vocals, and unconventional instruments establish a sonic landscape that feels appropriately alien while enhancing the emotional impact of key scenes.
The supporting cast brings depth to what could have been one-dimensional characters, with Rebecca Ferguson's Lady Jessica, Oscar Isaac's Duke Leto, and Jason Momoa's Duncan Idaho creating emotional anchors that help ground the film's more esoteric elements. Stellan Skarsgård's Baron Harkonnen achieves a physical menace that makes him a genuinely disturbing antagonist rather than merely a grotesque villain.
The film's approach to the political and religious themes of Herbert's novel is remarkably nuanced, presenting the manipulation of religious prophecy as a tool of colonialism without reducing the spiritual experiences of the Fremen to mere superstition. This respect for the complexity of belief systems gives the film a depth unusual in blockbuster filmmaking.
The action sequences, particularly the Harkonnen attack on Arrakeen, balance spectacular scale with human stakes, ensuring that the emotional impact of the violence isn't lost amid the visual spectacle. The shield technology visualization creates a distinctive aesthetic for combat that feels both futuristic and primal.
Patrice Vermette's production design creates environments that feel both alien and functional, with every structure and vehicle suggesting the culture that created it. The ornithopters in particular, with their dragonfly-like movement, solve the challenge of making these vehicles both visually distinctive and seemingly plausible.
The film's pacing demonstrates remarkable confidence, allowing for moments of quiet contemplation amid the spectacle. Villeneuve trusts his audience to absorb the complex worldbuilding without constant exposition, using visual storytelling to convey information whenever possible.
What ultimately distinguishes Villeneuve's Dune is how it balances the demands of modern blockbuster filmmaking with respect for the philosophical depth of its source material. Rather than simplifying Herbert's novel to make it more accessible, the film invites viewers to engage with its complexity, creating a rare science fiction epic that stimulates the mind as much as it dazzles the senses.},
  [
    %{The scale of Villeneuve's vision for Dune creates a sense of genuine awe rarely achieved in cinema. The vastness of Arrakis makes human figures seem appropriately insignificant against the desert landscape.},
    %{Hans Zimmer's score creates a sonic landscape as alien and immersive as the visual elements. The processed vocals, throat singing, and unconventional instruments establish a sound that feels both ancient and futuristic.},
    %{The film's approach to the political and religious themes of Herbert's novel shows remarkable nuance for a blockbuster. It presents the manipulation of prophecy without reducing the Fremen's spiritual experiences to mere superstition.},
    %{Timothée Chalamet captures Paul's internal struggle between his humanity and his potentially terrible purpose. His performance suggests a young man resisting yet gradually accepting a messianic role he neither fully understands nor desires.}
  ]
)

# Avatar (ID: 15)
create_reviews_for_movie(
  15,
  %{James Cameron's Avatar represents a watershed moment in cinematic technology, with its groundbreaking motion capture and 3D techniques creating an immersive alien world that forever changed audience expectations for visual effects. Beyond its technical achievements, the film offers a deeply felt environmental parable that resonates increasingly in our climate-threatened world.
The creation of Pandora stands as one of cinema's great worldbuilding achievements, with every aspect of its ecosystem feeling biologically plausible despite its fantastical elements. The bioluminescent forest, floating mountains, and interconnected neural network of plant life create an alien environment that feels more cohesive and thoroughly imagined than most science fiction settings.
Sam Worthington and Zoe Saldaña deliver performances that transcend the technological barriers of motion capture, creating genuine emotional connection despite the digital transformation of their appearances. Saldaña in particular brings fierce dignity and emotional depth to Neytiri, making her far more than an exotic love interest.
The film's environmental themes avoid simplistic preachiness by embedding them in the literal biology of Pandora, with its neural network of connections serving as both plot device and metaphor for the interconnectedness of all living things. This approach makes the ecological message feel organic to the story rather than imposed upon it.
The visual effects, developed over years of technological innovation, achieve a level of photorealism that allows viewers to forget they're watching computer-generated imagery. The Na'vi facial expressions in particular, with their subtle micro-movements and emotional nuance, crossed the "uncanny valley" that had limited previous motion capture attempts.
James Horner's score enhances the film's emotional impact, with its blend of orchestral grandeur and indigenous-inspired vocals creating a sonic landscape that complements the visual splendor without overwhelming it. The music helps bridge the gap between human and Na'vi cultures just as the avatar program does within the narrative.
The action sequences, particularly the final battle, balance spectacular scale with clear visual storytelling, ensuring that viewers never lose track of the geography or stakes despite the complexity of the conflict. Cameron's experience as an action director allows him to orchestrate chaos without creating confusion.
The film's exploration of colonialism and indigenous rights gains depth through its science fiction framework, allowing for a more nuanced examination of these issues than a direct historical analogy might permit. By placing human viewers in the perspective of the Na'vi through Jake's avatar, the film encourages empathy across the species divide.
The 3D technology, often gimmicky in lesser films, becomes an essential storytelling tool in Avatar, creating a sense of depth and immersion that enhances the audience's connection to Pandora. Cameron's careful composition for stereoscopic viewing set new standards for how the technology could serve narrative rather than merely spectacle.
What ultimately makes Avatar more than just a technical showcase is how it uses its groundbreaking visual elements to serve a story about connection—between species, between people and their environment, and between individuals. The film's lasting appeal lies in this emotional core beneath the spectacular surface, creating an experience that resonates beyond its immediate visual impact.},
  [
    %{The creation of Pandora represents one of cinema's greatest worldbuilding achievements. Every aspect of its ecosystem feels biologically plausible despite its fantastical elements, creating an alien world more cohesive than most science fiction settings.},
    %{The motion capture technology in Avatar finally crossed the "uncanny valley" that had limited previous attempts. The Na'vi facial expressions achieve a level of emotional nuance that allows viewers to connect with these digital characters as authentic beings.},
    %{James Cameron's mastery of action direction ensures that even the most complex battle sequences maintain clear visual storytelling. Viewers never lose track of the geography or stakes despite the spectacular scale of the conflict.},
    %{The film's environmental themes avoid simplistic preachiness by embedding them in Pandora's literal biology. The neural network connecting all life serves as both plot device and metaphor for ecological interconnectedness.},
    %{Avatar's use of 3D technology set new standards for how stereoscopic filming could serve narrative rather than merely provide gimmicky effects. The sense of depth and immersion enhances the audience's connection to this alien world.}
  ]
)

# Edge of Tomorrow (ID: 16)
create_reviews_for_movie(
  16,
  %{Doug Liman's Edge of Tomorrow (later rebranded as Live Die Repeat) represents science fiction at its most cleverly constructed, using its time-loop premise not merely as a gimmick but as a framework for genuine character development and narrative innovation. Based on Hiroshi Sakurazaka's novel All You Need Is Kill, the film transforms a video game-like structure of death and respawn into a compelling story about growth through failure.
Tom Cruise delivers one of his most interesting performances as Major William Cage, beginning as a cowardly PR officer before evolving into a hardened warrior through hundreds of repeated deaths and battles. This character arc inverts Cruise's typical heroic persona, allowing him to show vulnerability and fear before earning his eventual transformation.
Emily Blunt's Rita Vrataski, the "Angel of Verdun," provides both the film's emotional anchor and its action credentials, her battle-hardened efficiency making her the perfect mentor for Cage's repeated attempts to survive. Blunt brings physical conviction and emotional depth to a character who could have been merely a tough-soldier stereotype.
The film's editing deserves special recognition for how it handles the time-loop structure, showing just enough of each repetition to maintain narrative momentum without becoming repetitive. The progression from showing complete loops to cutting them short as Cage becomes more proficient creates a visual representation of his growing mastery.
The alien Mimics represent one of modern science fiction's most distinctive enemy designs, their whirling, metallic forms moving with a speed and unpredictability that makes them genuinely threatening. Their visual design suggests both mechanical and organic elements, creating creatures that feel truly alien rather than merely monstrous.
The exo-suit combat sequences balance spectacular action with clear stakes, the weight and limitations of the mechanical assistance adding both visual interest and narrative tension to the battle scenes. The training sequences in particular, with their repeated failures and incremental improvements, create a satisfying progression that earns the eventual combat proficiency.
The screenplay by Christopher McQuarrie, Jez Butterworth, and John-Henry Butterworth balances complex science fiction concepts with sharp dialogue and unexpected humor, finding comedy in Cage's repeated deaths without undermining the film's tension or emotional impact.
Dion Beebe's cinematography creates distinct visual identities for the sterile military environments and the chaotic battlefield, with the D-Day-inspired beach invasion sequence in particular capturing both the confusion of combat and the clarity necessary for audience comprehension.
The film's exploration of how repetition can lead to both mastery and meaning gives philosophical depth to what could have been merely a clever premise. Cage's journey from using his foreknowledge for selfish survival to sacrificing himself for others creates a moral dimension that elevates the science fiction concept.
What makes Edge of Tomorrow particularly satisfying is how it uses its high-concept premise to tell a fundamentally human story about overcoming fear, finding purpose, and connecting with others despite seemingly insurmountable barriers. The time loop becomes not just a plot device but a metaphor for the process of growth through persistent effort—a science fiction film that uses its fantastical elements to illuminate rather than escape human experience.},
  [
    %{The film's time-loop structure creates a perfect marriage of video game mechanics and cinematic storytelling. The "live, die, repeat" cycle turns failure into a path toward eventual success rather than merely a narrative dead end.},
    %{Tom Cruise's willingness to play against type as the initially cowardly Cage allows for one of his most interesting character arcs. His transformation from PR officer to warrior feels earned precisely because we see him fail so many times.},
    %{Emily Blunt brings physical conviction and emotional depth to Rita Vrataski, creating a female action hero whose competence doesn't come at the expense of her humanity. Her "Full Metal Bitch" persona masks genuine vulnerability.},
    %{The editing of the time-loop sequences demonstrates remarkable storytelling efficiency, showing just enough of each repetition to maintain narrative momentum without becoming tedious. The progression creates a visual representation of Cage's growing mastery.}
  ]
)

# Oppenheimer (ID: 17)
create_reviews_for_movie(
  17,
  %{Christopher Nolan's Oppenheimer represents cinema at its most ambitious, using the split perspectives of its protagonist and his security hearing interrogator to explore not just the creation of the atomic bomb but the moral complexities of scientific progress and national security. Shot partially in IMAX black-and-white film, the movie's formal experimentation matches its intellectual ambition.
Cillian Murphy delivers a career-defining performance as J. Robert Oppenheimer, capturing both the theoretical physicist's brilliant mind and his tortured conscience. Murphy's gaunt physicality and haunted eyes convey the weight of creating a weapon that forever changed humanity's relationship with its own survival.
The film's structure, alternating between Oppenheimer's subjective experience (shown in color) and the security hearing testimony of Lewis Strauss (shown in black and white), creates a complex narrative tapestry that examines how history is both made and written. This approach allows Nolan to explore multiple timeframes and perspectives without sacrificing clarity.
The supporting cast, including Emily Blunt as Kitty Oppenheimer, Matt Damon as General Leslie Groves, and Robert Downey Jr. as Lewis Strauss, creates a rich ensemble that embodies the various political, military, and personal forces surrounding the Manhattan Project. Downey in particular brings unexpected depth to Strauss, making his antagonism toward Oppenheimer feel rooted in genuine conviction rather than mere pettiness.
Ludwig Göransson's score enhances the mounting tension throughout, with its percussive elements suggesting both the ticking clock of the race against Nazi Germany and the mechanical precision of the scientific work. The music during the Trinity test sequence in particular creates an almost religious atmosphere appropriate to Oppenheimer's famous quotation from the Bhagavad Gita.
Hoyte van Hoytema's cinematography uses IMAX film to create images of stunning clarity and impact, particularly in the black-and-white sequences that give the security hearing an almost documentary-like immediacy. The contrast with the more subjective, color sequences of Oppenheimer's memories creates a visual language that helps viewers navigate the complex timeline.
The Trinity test sequence represents one of cinema's great set pieces, building unbearable tension through the scientists' uncertainty about whether the bomb might ignite the atmosphere while visualizing the awesome power of nuclear fission through both spectacular imagery and intimate human reactions. The moment captures both the scientific achievement and the moral horror simultaneously.
The film's exploration of Oppenheimer's political associations and the security hearing that stripped him of his clearance provides a nuanced examination of Cold War politics and the tension between scientific openness and national security. Rather than offering simple heroes and villains, Nolan presents the genuine complexity of these issues from multiple perspectives.
The production design recreates both the makeshift quality of the Los Alamos laboratory and the formal Washington hearing rooms with meticulous attention to period detail, creating environments that feel authentic to their historical moment while serving the film's thematic concerns.
What ultimately distinguishes Oppenheimer is how it uses its biographical framework to explore larger questions about scientific responsibility, government power, and the moral weight of creating weapons of unprecedented destructive capacity. By focusing on the man at the center of this pivotal historical moment, Nolan creates a film that feels both intimately personal and globally significant—a biographical drama with the scope and impact of an epic.},
  [
    %{Cillian Murphy's performance as Oppenheimer captures both the brilliant physicist and the tormented man. His gaunt physicality and haunted eyes convey the weight of creating a weapon that forever changed humanity's relationship with its own survival.},
    %{The Trinity test sequence represents one of cinema's great set pieces, building unbearable tension through scientific uncertainty while visualizing the awesome power of nuclear fission through both spectacular imagery and intimate human reactions.},
    %{Nolan's decision to shoot in IMAX black-and-white film for the security hearing sequences creates a documentary-like immediacy that contrasts effectively with the more subjective, color sequences of Oppenheimer's memories and experiences.},
    %{Robert Downey Jr. brings unexpected depth to Lewis Strauss, making his antagonism toward Oppenheimer feel rooted in genuine conviction rather than mere pettiness. His performance creates a complex antagonist rather than a simple villain.},
    %{The film's exploration of the tension between scientific openness and national security feels increasingly relevant in our current era. Rather than offering simple answers, Nolan presents the genuine complexity of these issues from multiple perspectives.}
  ]
)

# Spider-Man: No Way Home (ID: 18)
create_reviews_for_movie(
  18,
  %{Jon Watts' Spider-Man: No Way Home accomplishes the seemingly impossible task of satisfying both nostalgic fan service and genuine character development, using its multiverse premise to explore the essential nature of Peter Parker across different incarnations. What could have been merely a gimmick becomes a thoughtful examination of heroism, responsibility, and second chances.
Tom Holland delivers his most emotionally complex performance as Peter Parker, his journey from seeking an easy solution to his problems to making the ultimate sacrifice providing the emotional core that grounds the film's more fantastical elements. His ability to convey both youthful enthusiasm and profound loss makes this version of Peter feel fully realized.
The return of previous Spider-Man villains, particularly Alfred Molina's Doctor Octopus and Willem Dafoe's Green Goblin, creates antagonists with established emotional resonance rather than requiring new character development. Dafoe in particular reminds viewers of his remarkable ability to switch between Norman Osborn's vulnerability and the Goblin's menace with terrifying precision.
The appearance of Tobey Maguire and Andrew Garfield reprising their versions of Peter Parker represents fan service at its most emotionally effective, using nostalgia not merely for applause moments but to explore how different life experiences shape the same essential character. Their mentorship of Holland's younger Peter creates genuine emotional payoff beyond mere cameo value.
The film's exploration of second chances—both for the villains Peter tries to "cure" and for the alternate Peters who get to revisit their greatest failures—gives emotional depth to what could have been merely a multiverse adventure. By focusing on redemption rather than just defeat, the film honors Spider-Man's essential compassion across all incarnations.
Mauro Fiore's cinematography balances the spectacular action sequences with more intimate character moments, creating visual distinction between the different emotional registers of the story. The mirror dimension sequence in particular demonstrates how to create visually innovative action that serves character development rather than merely spectacle.
The supporting cast, particularly Zendaya as MJ and Jacob Batalon as Ned, provides crucial emotional grounding for Peter's journey. Their relationships with Peter give personal stakes to the multiverse crisis, ensuring that the film never loses sight of its human elements amid the interdimensional complications.
Michael Giacchino's score incorporates themes from previous Spider-Man films while establishing its own emotional identity, the musical callbacks enhancing the narrative connections between different versions of the character without overwhelming the current story.
The film's final act, with Peter making the ultimate sacrifice to restore the multiverse by having everyone forget his existence, transforms what began as a relatively light-hearted adventure into a genuinely moving exploration of heroism and responsibility. This bittersweet conclusion honors the character's essential tragedy—that being Spider-Man inevitably comes at a personal cost.
What ultimately distinguishes No Way Home from lesser multiverse stories is how it uses its high-concept premise to deepen rather than dilute its emotional impact. By exploring different versions of the same character, the film identifies the essential qualities that make Peter Parker/Spider-Man resonate across generations—his compassion, his resilience, and his willingness to sacrifice his own happiness for the greater good.},
  [
    %{Willem Dafoe's return as Green Goblin reminds viewers why he's one of superhero cinema's greatest villains. His ability to switch between Norman's vulnerability and the Goblin's menace with a simple facial expression remains terrifying.},
    %{The film's handling of the multiverse concept avoids getting lost in exposition by focusing on the emotional connections between different versions of Peter Parker. Their shared experiences create genuine moments of both humor and poignancy.},
    %{Tom Holland delivers his most emotionally complex performance as Peter Parker, particularly in the aftermath of Aunt May's death. His journey from seeking an easy solution to making the ultimate sacrifice gives the film unexpected emotional depth.},
    %{The final act transforms what began as a relatively light-hearted adventure into a genuinely moving exploration of heroism. Peter's decision to let everyone forget him represents the character's essential tragedy—that being Spider-Man inevitably comes at a personal cost.},
    %{The film's exploration of second chances—both for the villains Peter tries to "cure" and for the alternate Peters who get to revisit their greatest failures—gives emotional depth to what could have been merely a multiverse adventure.}
  ]
)

# Fast Five (ID: 19)
create_reviews_for_movie(
  19,
  %{Justin Lin's Fast Five represents the perfect evolution of a franchise, transforming what began as a relatively modest street racing series into a globe-trotting heist film with spectacular action set pieces and genuine character chemistry. By bringing together characters from previous installments and adding Dwayne Johnson's formidable presence, the film creates a found-family dynamic that would define the series moving forward.
The decision to pivot from street racing to heist movie opens up the franchise's potential, allowing for more varied action sequences while maintaining the emphasis on driving skills and vehicular spectacle. This genre shift acknowledges the need for evolution while honoring the core elements that made the series popular.
Dwayne "The Rock" Johnson's introduction as Luke Hobbs creates the perfect antagonist-turned-ally, his physical presence and charisma making him a credible threat to Dominic Toretto's crew while setting up the possibility of future collaboration. The fight between Johnson and Vin Diesel represents alpha-male cinema at its most enjoyably excessive.
The Rio de Janeiro setting provides both colorful visual backdrops and thematic resonance, with the favelas and wealth disparity creating a context that makes the crew's robbery of a corrupt businessman feel justified rather than merely criminal. This Robin Hood element gives moral dimension to what might otherwise be simply a spectacular heist.
The vault dragging sequence in the film's climax represents one of modern action cinema's most impressive set pieces, combining practical stunt work with digital enhancements to create a sequence that feels both physically impactful and deliriously over-the-top. The destruction caused by two multi-ton vaults being dragged through city streets creates action with genuine weight and consequence.
The ensemble cast chemistry, particularly between Vin Diesel, Paul Walker, Jordana Brewster, Tyrese Gibson, and Ludacris, creates a found-family dynamic that gives emotional stakes to the spectacular action. Their banter and clear affection for one another makes the audience invest in their survival and success beyond the immediate thrills.
Director Justin Lin's action choreography demonstrates remarkable spatial clarity, ensuring that even the most complex sequences maintain clear geography and causality. This approach allows for genuinely surprising moments within action scenes while never confusing the audience about what's happening and why.
The screenplay by Chris Morgan balances multiple character arcs and relationships while maintaining narrative momentum, giving each member of the ensemble meaningful contributions to both the plot and emotional dynamics. This attention to character amid spectacle would become a hallmark of the franchise moving forward.
Brian Tylor's cinematography captures both the vibrant colors of Rio and the gritty intensity of the action sequences, creating a visual palette that enhances the film's blend of escapist entertainment and genuine stakes. The contrast between sun-drenched establishing shots and the more intensely lit action creates visual variety throughout.
What ultimately makes Fast Five work so well is how it embraces the ridiculousness of its premise while maintaining emotional sincerity about its characters' relationships. By committing fully to both spectacular action and genuine connection between its ensemble, the film created a template that would allow the franchise to continue evolving in increasingly outlandish directions without losing its emotional core.},
  [
    %{The vault dragging sequence represents one of modern action cinema's most impressive set pieces, combining practical stunt work with digital enhancements to create something both physically impactful and deliriously over-the-top.},
    %{Dwayne Johnson's introduction as Luke Hobbs provided exactly what the franchise needed—a physically imposing antagonist whose charisma matched the established cast. His confrontations with Vin Diesel created a new energy that revitalized the series.},
    %{The decision to pivot from street racing to heist movie opened up the franchise's potential, allowing for more varied action sequences while maintaining the emphasis on driving skills and vehicular spectacle. This genre shift saved the series from repetition.},
    %{The ensemble cast chemistry creates a found-family dynamic that gives emotional stakes to the spectacular action. Their banter and clear affection for one another makes the audience invest in their survival beyond the immediate thrills.}
  ]
)

# The Departed (ID: 20)
create_reviews_for_movie(
  20,
  %{Martin Scorsese's The Departed represents the master filmmaker working at the height of his powers, transforming the Hong Kong thriller Infernal Affairs into a distinctly American crime epic steeped in the specific cultural tensions of Boston. The film's exploration of identity, loyalty, and moral compromise creates a psychological depth that elevates it beyond a standard cat-and-mouse thriller.
Leonardo DiCaprio delivers one of his most nuanced performances as Billy Costigan, capturing both the character's working-class toughness and the psychological toll of living a double life. His gradual unraveling as the pressure of his undercover assignment mounts creates a portrait of a man losing his sense of self in service to a greater cause.
Jack Nicholson's Frank Costello provides a perfect antagonist, his flamboyant menace and unpredictability creating genuine tension in every scene he occupies. Nicholson balances the character's charm and monstrosity, making Costello a villain whose gravitational pull on the other characters feels both seductive and destructive.
Matt Damon's Colin Sullivan represents the film's most complex moral challenge, his outward success and respectability masking a fundamental corruption. Damon's performance makes Sullivan not simply villainous but tragically compromised, a man whose early choices have trapped him in an increasingly untenable position.
The supporting cast, particularly Mark Wahlberg, Alec Baldwin, and Martin Sheen, creates a rich institutional context for the central conflict, their performances suggesting the complex power dynamics within law enforcement that both enable and threaten the film's protagonists. Wahlberg's profane intensity as Dignam in particular provides both comic relief and moral clarity amid the escalating deception.
Michael Ballhaus's cinematography captures both the gritty reality of Boston's criminal underworld and the sterile environments of law enforcement, the visual contrast enhancing the film's exploration of the thin line separating these supposedly opposed worlds. The use of surveillance imagery throughout reinforces the themes of watching and being watched that drive the narrative.
The screenplay by William Monahan transposes the original Hong Kong story into a specifically Boston context, using the city's unique blend of Catholicism, class tension, and tribal loyalty to create a moral universe where identity is both fiercely protected and fundamentally unstable. The dialogue crackles with profane energy while revealing character through distinctive speech patterns and word choice.
Thelma Schoonmaker's editing creates mounting tension through increasingly rapid cross-cutting between the parallel lives of Costigan and Sullivan, their mirrored experiences creating both narrative clarity and thematic resonance. The film's famous elevator sequence demonstrates how precise editing can create maximum impact from a moment of sudden violence.
The use of music, from the opening Stones track "Gimme Shelter" to the Irish folk influences in Howard Shore's score, enhances the film's exploration of cultural identity and tribal belonging. The soundtrack creates an auditory landscape that reinforces the specific Boston setting while connecting to Scorsese's broader cinematic world.
What ultimately distinguishes The Departed is how it uses its thriller framework to explore profound questions about identity and moral compromise. By following characters who must pretend to be what they're not—and others who pretend to be what they are—the film creates a complex meditation on the psychological cost of deception, both of others and of oneself.},
  [
    %{Leonardo DiCaprio's performance as Billy Costigan captures the psychological toll of living a double life with remarkable nuance. His gradual unraveling as the pressure mounts creates a portrait of a man losing his sense of self in service to a cause.},
    %{Jack Nicholson's Frank Costello provides the perfect antagonist, his flamboyant menace and unpredictability creating genuine tension in every scene. Nicholson balances the character's charm and monstrosity with veteran skill.},
    %{The film's exploration of Boston's unique blend of Catholicism, class tension, and tribal loyalty creates a moral universe where identity is both fiercely protected and fundamentally unstable. This specific cultural context gives the story additional resonance.},
    %{Thelma Schoonmaker's editing creates mounting tension through increasingly rapid cross-cutting between the parallel lives of Costigan and Sullivan. The film's famous elevator sequence demonstrates how precise editing can create maximum impact from a moment of sudden violence.},
    %{Martin Scorsese transforms what could have been a standard cat-and-mouse thriller into a complex meditation on identity and moral compromise. By following characters who must pretend to be what they're not, the film explores the psychological cost of deception.}
  ]
)

# The Dark Knight
create_reviews_for_movie(
  3,
  %{Christopher Nolan's The Dark Knight transcends the superhero genre to deliver a crime epic of extraordinary moral complexity. Heath Ledger's posthumous Oscar-winning performance as the Joker creates a villain whose philosophical provocations elevate the film beyond typical comic book adaptations into a meditation on order, justice, and the thin line between heroism and vigilantism.
Christian Bale's dual performance as Bruce Wayne and Batman provides the perfect counterweight to Ledger's chaos agent, his rigid moral code and growing isolation creating a hero whose sacrifices feel genuinely costly. The film's visual language eschews stylized gothic elements for a grounded approach to Gotham City, using Chicago's urban landscape to create a believable metropolitan environment.
What ultimately distinguishes The Dark Knight is its willingness to leave its hero in a place of moral ambiguity and isolation, suggesting that sometimes the maintenance of social order requires not just sacrifice but the acceptance of false narratives and misplaced blame.},
  [
    %{Ledger's Joker is a masterclass in villainy—unpredictable, philosophical, and genuinely terrifying without relying on supernatural powers.},
    %{The film's action sequences serve character and theme rather than mere spectacle, with practical effects creating a tangible reality that grounds even the most elaborate set pieces.},
    %{Hans Zimmer's score creates an atmosphere of relentless unease that perfectly complements the film's exploration of escalation and societal breakdown.},
    %{The screenplay structures its narrative around moral dilemmas rather than mere plot mechanics, forcing characters and audience alike to confront uncomfortable questions about justice.}
  ]
)
# Fight Club
create_reviews_for_movie(
  27,
  %{David Fincher's Fight Club is a subversive masterpiece that captures the millennial male identity crisis through its unreliable narrator and visceral exploration of consumer culture. Edward Norton and Brad Pitt deliver career-defining performances as the nameless narrator and Tyler Durden, two sides of a fractured psyche rebelling against modern emasculation.
The film's visual style—with its gritty textures, subliminal flashes, and kinetic editing—perfectly complements its themes of disillusionment and anarchic release. Fincher's direction creates a world that feels simultaneously hyperreal and hallucinatory, mirroring the protagonist's deteriorating grip on reality.
Twenty-plus years after its release, Fight Club remains provocative and prescient in its examination of toxic masculinity, cult mentality, and the emptiness of consumer identity, culminating in one of cinema's most iconic twist endings and final images.},
  [
    %{The film's dark humor and satirical edge prevent its nihilistic themes from becoming oppressive, finding comedy in the absurdity of modern male anxiety.},
    %{Cinematographer Jeff Cronenweth creates a visual palette that evolves throughout the film, from the sterile blues of corporate life to the warm, organic tones of the fight club sequences.},
    %{Helena Bonham Carter's Marla Singer provides the perfect chaotic counterpoint to the narrator's structured existence, her self-destructive honesty exposing his own carefully constructed lies.},
    %{The Dust Brothers' electronic score creates a pulsing, industrial soundscape that enhances the film's themes of mechanization and primal release.}
  ]
)
# Ice Age:2002
create_reviews_for_movie(
  28,
  %{Ice Age blends prehistoric adventure with heartfelt emotion, creating a family film that appeals across generations. The unlikely trio of Manny the mammoth, Sid the sloth, and Diego the saber-toothed tiger forms the emotional core of the story, their journey to return a human baby becoming a path to found family and redemption.
The animation, while dated by today's standards, showcases Blue Sky Studios' innovative approach to character design and environmental effects, particularly in the expressive character work and ice-filled landscapes. Scrat's acorn-chasing interludes provide perfect comic relief between the main story's more emotional moments.
With its themes of extinction, survival, and chosen family, Ice Age delivers surprising emotional depth beneath its comedic exterior, establishing a franchise that would span decades.},
  [
    %{Ray Romano's voice performance as Manny brings unexpected warmth to the gruff mammoth, his deadpan delivery creating perfect comedic tension with John Leguizamo's manic energy as Sid.},
    %{The film balances prehistoric peril with accessible humor, never talking down to its younger audience while maintaining stakes that feel genuinely consequential.},
    %{Scrat's wordless, Chaplin-esque pursuit of his acorn represents some of the most purely entertaining animation in modern family films.},
    %{The score by David Newman enhances both the epic scale of the ice age setting and the intimate emotional moments between characters.}
  ]
)
# Jurassic Park
create_reviews_for_movie(
  29,
  %{Steven Spielberg's Jurassic Park revolutionized visual effects while delivering a perfect blend of wonder, terror, and scientific cautionary tale. The film's dinosaurs—combining groundbreaking CGI with practical effects—remain convincing nearly three decades later, their introduction scene with the Brachiosaurus standing as one of cinema's most magical moments.
The human characters, from Sam Neill's reluctant paleontologist to Jeff Goldblum's charismatic chaos theorist, provide relatable anchors amid the prehistoric spectacle. Their scientific and ethical debates give intellectual weight to what could have been merely a monster movie.
John Williams' iconic score perfectly captures both the awe-inspiring majesty of the dinosaurs and the terrifying pursuit sequences, while Spielberg's masterful direction creates set pieces—particularly the T-Rex attack and kitchen velociraptor hunt—that remain benchmarks for tension and release in blockbuster filmmaking.},
  [
    %{The film's visual effects represent a watershed moment in cinema, seamlessly blending CGI and practical dinosaurs in ways that still impress in our effects-saturated era.},
    %{Spielberg's direction demonstrates his unparalleled ability to balance childlike wonder with genuine terror, often within the same sequence.},
    %{The screenplay adapts Michael Crichton's more technical novel into an accessible adventure while preserving its core warnings about scientific hubris and corporate exploitation.},
    %{The T-Rex attack sequence remains a masterclass in escalating tension, using sound, rain, and restricted visibility to maximize impact before revealing the dinosaur in all its terrifying glory.}
  ]
)
# Inside Out
create_reviews_for_movie(
  30,
  %{Pixar's Inside Out transforms the abstract concept of emotions into a vibrant, visually stunning adventure inside the mind of an 11-year-old girl. The film's genius lies in making complex psychological concepts accessible without simplifying them, creating characters from emotions that feel fully realized rather than mere abstractions.
Amy Poehler's Joy and Phyllis Smith's Sadness form the emotional heart of the film, their journey through Riley's mind becoming a nuanced exploration of emotional development and the essential role of melancholy in a balanced psyche. The film's willingness to acknowledge sadness as necessary rather than negative sets it apart from typical children's entertainment.
The production design creates distinct visual identities for each emotion and mental space, from the glowing memory orbs to the crumbling islands of personality, making abstract psychological concepts tangible without losing their complexity.},
  [
    %{The film's most profound achievement is making children and adults alike understand that sadness isn't an emotion to be suppressed but an essential part of processing life's changes.},
    %{Michael Giacchino's score creates distinct musical identities for each emotion while maintaining a cohesive soundscape that enhances the film's emotional impact.},
    %{The abstract thought sequence, where the characters transform through different artistic styles, represents some of the most creative animation in Pixar's illustrious history.},
    %{Bing Bong's sacrifice scene delivers one of animation's most heartbreaking moments, capturing the bittersweet necessity of leaving childhood behind.}
  ]
)

# Joker
create_reviews_for_movie(
  31,
  %{Todd Phillips' Joker reimagines the iconic villain's origin through the lens of 1970s character-driven cinema, with Joaquin Phoenix delivering a physically transformative performance that earned him a well-deserved Oscar. The film's Gotham City, modeled after New York's grimiest era, becomes a character itself—a pressure cooker of economic inequality and institutional failure that creates the conditions for Arthur Fleck's descent.
Lawrence Sher's cinematography captures both the gritty urban decay and Arthur's increasingly distorted perspective, while Hildur Guðnadóttir's cello-driven score creates an atmosphere of mounting dread and twisted triumph. The film's controversial approach to violence makes its few outbursts more impactful through their relative scarcity.
By divorcing the character from Batman and traditional comic book trappings, Joker creates a disturbing character study that forces audiences to confront uncomfortable questions about mental illness, societal neglect, and the thin line between victimhood and villainy.},
  [
    %{Phoenix's physical performance—from his emaciated frame to his unsettling dance movements—creates a character whose external transformation visibly manifests his internal deterioration.},
    %{The film's ambiguous approach to Arthur's reality, particularly regarding his relationship with Sophie, creates a narrative unreliability that mirrors the character's fractured perspective.},
    %{The talk show sequence represents a perfect culmination of the film's themes, bringing Arthur's private delusions into devastating public reality.},
    %{Despite its comic book origins, the film functions as a disturbing meditation on how society's failures create the very monsters it then condemns.}
  ]
)
# The Hunger Games
create_reviews_for_movie(
  32,
  %{Gary Ross's adaptation of Suzanne Collins' dystopian novel captures the brutal social commentary of its source material while establishing Jennifer Lawrence as a formidable leading actress. Her performance as Katniss Everdeen balances vulnerability with fierce determination, creating a heroine whose strength comes from necessity rather than superheroic exceptionalism.
The film's visual contrast between the impoverished Districts and the garish Capitol effectively communicates the story's political themes without heavy-handed exposition. The reality television aspects of the Games themselves feel disturbingly prescient in our media-saturated culture, with Stanley Tucci's Caesar Flickerman embodying entertainment's complicity in normalized violence.
While some of the action sequences suffer from shaky camerawork that obscures rather than enhances the violence (likely to maintain a teen-friendly rating), the film succeeds in establishing a dystopian world that feels both fantastical and uncomfortably plausible in its exploitation of the many for the entertainment of the few.},
  [
    %{Lawrence's performance elevates the material beyond typical young adult fare, bringing emotional depth and physical conviction to Katniss's journey from survivor to reluctant symbol.},
    %{The film's costume and production design, particularly for the Capitol sequences, create a visual language of excess that effectively communicates the story's class critique.},
    %{The adaptation wisely maintains Katniss's first-person perspective from the novel through selective narration, allowing audiences to experience the Games through her increasingly traumatized viewpoint.},
    %{Woody Harrelson's Haymitch provides necessary gallows humor while embodying the long-term psychological damage the Games inflict on even their survivors.}
  ]
)
# The Lord of the Rings: The Fellowship of the Ring
create_reviews_for_movie(
  33,
  %{Peter Jackson's The Fellowship of the Ring transformed J.R.R. Tolkien's supposedly unfilmable epic into a landmark achievement in fantasy cinema. The film balances spectacular world-building with intimate character moments, establishing Middle-earth as a fully realized world with its own history, languages, and cultures rather than merely a backdrop for adventure.
The ensemble cast embodies their literary counterparts while bringing new dimensions to them, with particular standouts in Ian McKellen's wise but fallible Gandalf, Viggo Mortensen's reluctant hero Aragorn, and Sean Bean's tragically flawed Boromir. Their interactions create a fellowship that feels genuinely bonded, making its eventual fracturing emotionally impactful.
Andrew Lesnie's cinematography captures both New Zealand's sweeping landscapes and the intimate character moments with equal attention to detail, while Howard Shore's score establishes distinct musical identities for each culture and character that would develop throughout the trilogy, creating one of cinema's most cohesive and emotionally resonant musical landscapes.},
  [
    %{The film's practical effects and forced perspective techniques, combined with groundbreaking digital work, create a world where hobbits, elves, dwarves, and humans interact with convincing scale differences.},
    %{Jackson's direction maintains narrative clarity despite the complexity of Tolkien's world, making the intricate mythology accessible without simplifying its moral and thematic depth.},
    %{The Moria sequence represents a perfect balance of tension, action, and emotional consequence, with the Balrog emergence and Gandalf's fall creating one of modern cinema's most impactful moments.},
    %{The film's extended edition enhances character development and world-building without sacrificing narrative momentum, setting a standard for how additional footage can genuinely enrich rather than merely extend a theatrical release.}
  ]
)



# Availability types
availabilities = %w[stream free add buy rent]

availabilities.each do |availability_type|
  Availability.find_or_create_by(name: availability_type)
end


# Movie availabilities
movie_availabilities = {
  1 => [1, 3],           # The Shawshank Redemption - stream, add
  2 => [1, 2],           # The Godfather - stream, free
  3 => [2, 3],           # The Dark Knight - free, add
  4 => [1, 4, 5],        # Inception - stream, buy, rent
  5 => [1, 2, 4],        # The Matrix - stream, free, buy
  6 => [1, 5],           # GoodFellas - stream, rent
  7 => [3, 5],           # The Others - add, rent
  8 => [1, 3, 5],        # Rush Hour - stream, add, rent
  9 => [2, 4, 5],        # Home Alone - free, buy, rent
  10 => [1, 2],          # The Mask - stream, free
  11 => [1, 5],          # The Conjuring - stream, rent
  12 => [1, 3, 4],       # John Wick - stream, add, buy
  13 => [2, 3, 5],       # Interstellar - free, add, rent
  14 => [1, 4, 5],       # Dune - stream, buy, rent
  15 => [2, 3, 4],       # Avatar - free, add, buy
  16 => [1, 3, 5],       # Edge of Tomorrow - stream, add, rent
  17 => [1, 4],          # Oppenheimer - stream, buy
  18 => [1, 4, 5],       # Spider-Man: No Way Home - stream, buy, rent
  19 => [1, 2, 5],       # Fast Five - stream, free, rent
  20 => [1, 3, 4],       # The Departed - stream, add, buy
  21 => [1, 5],          # Heat - stream, rent
  22 => [2, 4, 5],       # Casino - free, buy, rent
  23 => [1, 3, 5],       # A Quiet Place - stream, add, rent
  24 => [1, 2, 4],       # The Ring - stream, free, buy
  25 => [2, 3, 5],       # Insidious - free, add, rent
  26 => [1, 3, 4, 5],    # 21 Jump Street - stream, add, buy, rent
  27 => [3, 5],          # Fight Club - add, rent
  28 => [1, 4, 5],       # Ice Age:2002 - stream, buy, rent
  29 => [2, 3, 4],       # Jurassic Park:1993 - free, add, buy
  30 => [1, 3, 5],       # Inside Out: - stream, add, rent
  31 => [1, 3, 4, 5],    # Joker:2019 - stream, add, buy, rent
  32 => [1, 2, 5],       # The Hunger Games - stream, free, rent
  33 => [1, 3, 4]        # The Lord of the Rings - stream, add, buy
}


def create_movie_availabilities(movie_id, availabilities)
  availabilities.each do |availability_id|
    MovieAvailability.create!(
      movie_id: movie_id,
      availability_id: availability_id
    )
  end
end


movie_availabilities.each do |movie_id, availability_ids|
  create_movie_availabilities(movie_id, availability_ids)
end


# Release formats
release_formats = %w[theatrical premiere digital physical TV]

release_formats.each do |release_format|
  ReleaseFormat.find_or_create_by(name: release_format)
end


movie_release_formats = {
  1 => [1, 3, 4],        # The Shawshank Redemption - theatrical, digital, physical
  2 => [1, 2, 4],        # The Godfather - theatrical, premiere, physical
  3 => [1, 3, 4],        # The Dark Knight - theatrical, digital, physical
  4 => [1, 2, 3, 4],     # Inception - theatrical, premiere, digital, physical
  5 => [1, 3, 4],        # The Matrix - theatrical, digital, physical
  6 => [1, 4],           # GoodFellas - theatrical, physical
  7 => [1, 3, 4],        # The Others - theatrical, digital, physical
  8 => [1, 3, 4],        # Rush Hour - theatrical, digital, physical
  9 => [1, 3, 4, 5],     # Home Alone - theatrical, digital, physical, TV
  10 => [1, 3, 4],       # The Mask - theatrical, digital, physical
  11 => [1, 3, 4],       # The Conjuring - theatrical, digital, physical
  12 => [1, 3, 4],       # John Wick - theatrical, digital, physical
  13 => [1, 2, 3, 4],    # Interstellar - theatrical, premiere, digital, physical
  14 => [1, 2, 3, 4],    # Dune - theatrical, premiere, digital, physical
  15 => [1, 2, 3, 4],    # Avatar - theatrical, premiere, digital, physical
  16 => [1, 3, 4],       # Edge of Tomorrow - theatrical, digital, physical
  17 => [1, 2, 3, 4],    # Oppenheimer - theatrical, premiere, digital, physical
  18 => [1, 2, 3, 4],    # Spider-Man: No Way Home - theatrical, premiere, digital, physical
  19 => [1, 3, 4],       # Fast Five - theatrical, digital, physical
  20 => [1, 2, 3, 4],    # The Departed - theatrical, premiere, digital, physical
  21 => [1, 3, 4],       # Heat - theatrical, digital, physical
  22 => [1, 4],          # Casino - theatrical, physical
  23 => [1, 3, 4],       # A Quiet Place - theatrical, digital, physical
  24 => [1, 3, 4],       # The Ring - theatrical, digital, physical
  25 => [1, 3, 4],       # Insidious - theatrical, digital, physical
  26 => [1, 3, 4],       # 21 Jump Street - theatrical, digital, physical
  27 => [1, 3, 4],       # Fight Club - theatrical, digital, physical
  28 => [1, 3, 4, 5],    # Ice Age:2002 - theatrical, digital, physical, TV
  29 => [1, 2, 3, 4],    # Jurassic Park:1993 - theatrical, premiere, digital, physical
  30 => [1, 3, 4, 5],    # Inside Out: - theatrical, digital, physical, TV
  31 => [1, 2, 3, 4],    # Joker:2019 - theatrical, premiere, digital, physical
  32 => [1, 2, 3, 4],    # The Hunger Games - theatrical, premiere, digital, physical
  33 => [1, 2, 3, 4]     # The Lord of the Rings: The Fellowship of the Ring - theatrical, premiere, digital, physical
}

def create_movie_release_formats(movie_id, release_formats)
  release_formats.each do |release_format_id|
    MovieReleaseFormat.create!(
      movie_id: movie_id,
      release_format_id: release_format_id
    )
  end
end

movie_release_formats.each do |movie_id, release_format_ids|
  create_movie_release_formats(movie_id, release_format_ids)
end


# Ratings
def create_rating_for_long_reviewer(movie_id)
  long_review_user_id = (movie_id % 10 == 0) ? 10 : movie_id % 10

  Rating.create!(
    user_id: long_review_user_id,
    movie_id: movie_id,
    score: [20, 30, 40, 40, 50, 60, 70, 70, 80, 90, 90].sample
  )
end

(1..33).each do |movie_id|
  create_rating_for_long_reviewer(movie_id)
end
