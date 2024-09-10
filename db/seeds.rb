# users

User.create!(username: "user1", email: "user1@example.com", password: "user1@example.com", password_confirmation: "user1@example.com")
User.create!(username: "user2", email: "user2@example.com", password: "user2@example.com", password_confirmation: "user2@example.com")
User.create!(username: "user3", email: "user3@example.com", password: "user3@example.com", password_confirmation: "user3@example.com")
User.create!(username: "user4", email: "user4@example.com", password: "user4@example.com", password_confirmation: "user4@example.com")
User.create!(username: "user5", email: "user5@example.com", password: "user5@example.com", password_confirmation: "user5@example.com")
User.create!(username: "user6", email: "user6@example.com", password: "user6@example.com", password_confirmation: "user6@example.com")
User.create!(username: "user7", email: "user7@example.com", password: "user7@example.com", password_confirmation: "user7@example.com")
User.create!(username: "user8", email: "user8@example.com", password: "user8@example.com", password_confirmation: "user8@example.com")
User.create!(username: "user9", email: "user9@example.com", password: "user9@example.com", password_confirmation: "user9@example.com")
User.create!(username: "user10", email: "user10@example.com", password: "user10@example.com", password_confirmation: "user10@example.com")

Category.create!([{ name: 'Horror' }, { name: 'Thriller' }, { name: 'Mystery' }, { name: 'Crime' }, { name: 'Action' }, { name: 'Science Fiction' }, { name: 'Drama' }])

Role.create!([{ name: 'cast' }, { name: 'director' }, { name: 'writer' }, { name: 'screenplay' }, { name: 'story' }, { name: 'novel' }, { name: 'characters' }])

Movie.create!(title: "John Wick: Chapter 4", language: "en", age_rating: "R", budget: "44285000", duration: 170, release_date: Date.new(2023, 03, 24), revenue: "123456789.24", tagline: "No way back, one way out.", overview: "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.", image_filename: "john_wick.jpg", gradient_color: "#331F1F")
Movie.create!(title: "The Little Mermaid", language: "en", age_rating: "PG", budget: "44285000", duration: 135, release_date: Date.new(2023, 05, 26), revenue: "123456789.24", tagline: "Watch and you'll see, some day I'll be, part of your world!", overview: "The youngest of King Triton’s daughters, and the most defiant, Ariel longs to find out more about the world beyond the sea, and while visiting the surface, falls for the dashing Prince Eric. With mermaids forbidden to interact with humans, Ariel makes a deal with the evil sea witch, Ursula, which gives her a chance to experience life on land, but ultimately places her life – and her father’s crown – in jeopardy.", image_filename: "little_mermaid.jpg", gradient_color: "#331F1F")
Movie.create!(title: "FUBAR", language: "es", age_rating: "TV-MA", budget: "44285000", duration: 101, release_date: Date.new(2023, 05, 19), revenue: "123456789.24", tagline: "Heroes don't retire. They reload.", overview: "When a father and daughter discover they both secretly work for the CIA, an already dicey undercover mission turns into a dysfunctional family affair.", image_filename: "john_wick.jpg", gradient_color: "#331F1F")
Movie.create!(title: "Fast X", language: "it", age_rating: "PG-13", budget: "44285000", duration: 142, release_date: Date.new(2001, 10, 8), revenue: "123456789.24", tagline: "The end of the road begins.", overview: "Over many missions and against impossible odds, Dom Toretto and his family have outsmarted, out,nerved and outdriven every foe in their path. Now, they confront the most lethal opponent they've ever faced: A terrifying threat emerging from the shadows of the past who's fueled by blood revenge, and who is determined to shatter this family and destroy everything—and everyone—that Dom loves, forever.", image_filename: "fast_x.jpg", gradient_color: "#1F1F1F")
Movie.create!(title: "Blood & Gold", language: "ko", age_rating: "R", budget: "44285000", duration: 100, release_date: Date.new(2023, 05, 26), revenue: "123456789.24", overview: "At the end of World War II, a German soldier is looking for his daughter while an SS troop is looking for a Jewish treasure.", image_filename: "fubar.jpeg", gradient_color: "#331F1F")
Movie.create!(title: "The Super Mario Bros. Movie", language: "ko", age_rating: "PG", budget: "44285000", duration: 92, release_date: Date.new(2023, 04, 05), revenue: "123456789.24", overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.", image_filename: "super_mario.jpg", gradient_color: "#331F1F")
Movie.create!(title: "Dungeons & Dragons: Honor Among Thieves", language: "ja", age_rating: "PG-13", budget: "44285000", duration: 134, release_date: Date.new(2023, 03, 31), revenue: "123456789.24", tagline: "No experience necessary.", overview: "A charming thief and a band of unlikely adventurers undertake an epic heist to retrieve a lost relic, but things go dangerously awry when they run afoul of the wrong people.", image_filename: "dungeons.jpg", gradient_color: "#331F1F")
Movie.create!(title: "Tin & Tina", language: "en", age_rating: "16", budget: "44285000", duration: 119, release_date: Date.new(2023, 05, 26), revenue: "123456789.24", overview: "After a traumatic miscarriage, Lola and her husband Adolfo adopt Tin and Tina, a lovely albino brother and sister with an ultra,catholic education that makes them interpret Holy Bible verbatim.", image_filename: "tin_tina.jpg", gradient_color: "#331F1F")
Movie.create!(title: "Succession", language: "en", age_rating: "TV-MA", budget: "44285000", duration: 101, release_date: Date.new(2001, 10, 18), revenue: "123456789.24", tagline: "Make your move.", overview: "Follow the lives of the Roy family as they contemplate their future once their aging father begins to step back from the media and entertainment conglomerate they control.", image_filename: "succession.jpg", gradient_color: "#331F1F")
Movie.create!(title: "The Others", language: "en", age_rating: "PG-13", budget: "17000000.00", duration: 101, release_date: Date.new(2001, 10, 8), revenue: "21000000000", tagline: "Sooner or later they’ll find you.", overview: "Grace is a religious woman who lives in an old house kept dark because her two children, Anne and Nicholas, have a rare sensitivity to light. When the family begins to suspect the house is haunted, Grace fights to protect her children at any cost in the face of strange events and disturbing visions.", image_filename: "the_others.jpg", gradient_color: "#331F1F")
Movie.create!(title: "Shutter Island", language: "en", age_rating: "R", budget: "17,000,000.00", duration: 138, release_date: Date.new(2010, 2, 19), revenue: "294800000.24", tagline: "Some places never let you go.", overview: "World War II soldier-turned-U.S. Marshal Teddy Daniels investigates the disappearance of a patient from a hospital for the criminally insane, but his efforts are compromised by troubling visions and a mysterious doctor.", image_filename: "shutter_island.jpg", gradient_color: "#0a1f1f")
Movie.create!(title: "Face/Off", language: "fr", age_rating: "R", budget: "44285000", duration: 138, release_date: Date.new(1997, 06, 27), revenue: "245676146.24", tagline: "In order to trap him, he must become him.", overview: "In order to foil a terrorist plot, an FBI agent undergoes facial transplant surgery and assumes the identity of a criminal mastermind. The plan turns sour when the criminal wakes up prematurely and seeks revenge.", image_filename: "face_off.jpg", gradient_color: "#dcb29d")
Movie.create!(title: "Cube", language: "en", age_rating: "R", budget: "44285000", duration: 90, release_date: Date.new(1998, 8, 11), revenue: "8969065.00", tagline: "Don't look for a reason... Look for a way out.", overview: "A group of strangers find themselves trapped in a maze-like prison. It soon becomes clear that each of them possesses the peculiar skills necessary to escape, if they don't wind up dead first.", image_filename: "cube.jpg", gradient_color: "#344973")

Person.create!(name: "Vin Diesel", profession: "actor", gender: "male", date_of_birth: "1967-07-18", place_of_birth: "Alameda County, California, USA", credits: 83, biography: "Mark Sinclair (born July 18, 1967), known professionally as Vin Diesel, is an American actor and producer. One of the world's highest-grossing actors, he is best known for playing Dominic Toretto in the Fast & Furious franchise. Diesel began his career in 1990, but faced difficulty achieving recognition until he wrote, directed and starred in the short film Multi-Facial (1995) and his debut feature Strays (1997); the films prompted Steven Spielberg to cast Diesel in the war epic Saving Private Ryan (1998). Diesel subsequently voiced the titular character in The Iron Giant (1999) and then gained a reputation as an action star after headlining the Fast & Furious, XXX, and The Chronicles of Riddick franchises. He is slated to appear in the upcoming Avatar films. Diesel voices Groot and Groot II in the Marvel Cinematic Universe (MCU); he portrayed the characters in six superhero films, beginning with Guardians of the Galaxy (2014). Diesel has reprised his role as Groot for the Disney+ animated shorts series I Am Groot (2022–present), the television special The Guardians of the Galaxy Holiday Special (2022), and the animated film Ralph Breaks the Internet (2018). Diesel achieved commercial success in the comedy The Pacifier (2005) and his portrayal of Jackie DiNorscio in Find Me Guilty (2006) was praised. He founded the production company One Race Films, where he has also served as a producer or executive producer for his star vehicles. Diesel also founded the record label Racetrack Records and video game developer Tigon Studios, providing his voice and motion capture for all of Tigon's releases. Description above from the Wikipedia article Vin Diesel, licensed under CC-BY-SA, full list of contributors on Wikipedia.", image_filename: "vin.jpg")
Person.create!(name: "Michelle Rodriguez", profession: "actor", gender: "female", date_of_birth: "1978-07-12", place_of_birth: "Bexar County, Texas, USA", credits: 67, biography: 'Mayte Michelle Rodríguez (born July 12, 1978), known professionally as Michelle Rodriguez, is an American actress, screenwriter, and DJ. She got her breakout role as a troubled boxer in the independent film Girlfight (2000), which was met with critical acclaim and earned her several awards, including the Independent Spirit Award and Gotham Award for Best Debut Performance. The following year, she starred as Letty Ortiz in the blockbuster film The Fast and the Furious (2001), reprising her role in its sequels Fast & Furious (2009), Fast & Furious 6 (2013), and Furious 7 (2015). During her career, Rodriguez has played tough, independent women in a number of successful action films, such as Blue Crush, S.W.A.T., Battle: Los Angeles, and Avatar. She is also known for her roles as Shé in the action comedy films Machete and Machete Kills, and Rain Ocampo in the science fiction films Resident Evil and Resident Evil: Retribution. Rodriguez also branched into television, playing Ana Lucia Cortez in the second season of the series Lost as part of the main cast, before making numerous guest appearances before the series ended. She has also done voice work in video games such as Call of Duty and Halo, and lent her voice for the 3D animated film Turbo and the television series IGPX. With her films grossing over $5 billion collectively, a 2013 Entertainment Weekly article described Rodriguez as "arguably the most iconic actress in the action genre, as well as one of the most visible Latinas in Hollywood".', image_filename: "michelle.jpg")
Person.create!(name: "Tyrese Gibson", profession: "actor", gender: "male", date_of_birth: "1978-12-30", place_of_birth: "Los Angeles, California, USA", credits: 63, biography: "Tyrese Darnell Gibson (born December 30, 1978), also known mononymously as Tyrese, is an American Grammy-nominated R&B singer, songwriter, actor, author, television producer, former fashion model and MTV VJ. He is best known for his role as Roman Pearce in the The Fast and the Furious series.", image_filename: "tyrese.jpg")
Person.create!(name: "Ludacris", profession: "actor", gender: "male", date_of_birth: "1977-09-11", place_of_birth: "Champaign, Illinois, USA", credits: 86, biography: "Christopher Brian Bridges (born September 11, 1977), known professionally as Ludacris, is an American rapper and actor. After forming his own label, Disturbing tha Peace in the late 1990s, Ludacris later signed with Def Jam South and would go on to become one of the first Dirty South rappers to achieve mainstream success with his subsequent releases. For his music, Ludacris has won an MTV Video Music Award and three Grammy Awards. As an actor, Ludacris is best known for his role as Tej Parker in the Fast and Furious film series, with his first appearance in the franchise coming in 2003. His other notable roles include Crash (2004), Gamer (2009), and New Year's Eve (2011). For his performance in the ensemble of Crash, Ludacris was co-awarded a Screen Actors Guild Award and a Critic's Choice Award for Best Cast.", image_filename: "ludacris.jpg")
Person.create!(name: "John Cena", profession: "actor", gender: "male", date_of_birth: "1977-04-23", place_of_birth: "West Newbury, Massachusetts, USA", credits: 392, biography: "John Felix Anthony Cena is an American professional wrestler, actor, and former rapper currently signed to WWE. Widely regarded as one of the greatest professional wrestlers of all time, he is tied with Ric Flair for the most world championship reigns in professional wrestling history. Born and raised in West Newbury, Massachusetts, Cena moved to California in 1998 to pursue a career as a bodybuilder. He transitioned to professional wrestling in 1999 when he debuted for Ultimate Pro Wrestling (UPW). He signed with the World Wrestling Federation (WWF, now WWE) in 2001, where he was initially assigned to Ohio Valley Wrestling (OVW). He gained fame in the WWE after adopting the persona of a trash-talking rapper. He won his first singles title, the United States Championship, in 2004. The next year, he won the WWE Championship for the first time, and his character subsequently transitioned into a clean-cut 'Superman-like' hero. He then led the company as its franchise player, and public face for the next decade. A joint-record 16-time world champion, Cena has won the WWE Championship thirteen times, a record for the title. He is also a five-time United States Champion, a four-time world tag team champion, a two-time Royal Rumble match winner, a one-time Money in the Bank match winner, and has headlined several major WWE pay-per-view events, including their flagship event, WrestleMania, five times. His professional wrestling career has been met with mixed critical and audience reception, with praise for his character work and promotional skills, but criticism for his supposed over-representation and on-screen placement relative to other wrestlers. Cena first starred in The Marine (2006), and gained praise for his performances in Trainwreck (2015), Ferdinand (2017), Blockers, and Bumblebee (both 2018). He starred in F9 and portrayed Peacemaker in The Suicide Squad (both 2021) and in the eponymous television series. His debut studio album, You Can't See Me (2005), was certified platinum. Outside his work in entertainment, Cena is known for his involvement in numerous charitable causes, namely with the Make-A-Wish Foundation, where he has granted the most wishes, at over 650.", image_filename: "john.jpg")
Person.create!(name: "Nathalie Emmanuel", profession: "actor", gender: "female", date_of_birth: "1989-03-02", place_of_birth: "Southend-on-Sea, Essex, England, UK", credits: 34, biography: "Nathalie Joanne Emmanuel (born 2 March 1989) is an English actress best known for her role as Sasha Valentine in the soap opera Hollyoaks, Computer Hacktivist Ramsey in the action film Furious 7 and as the interpreter Missandei on the HBO fantasy series Game of Thrones.", image_filename: "nathalie.jpg")
Person.create!(name: "Jordana Brewster", profession: "actor", gender: "female", date_of_birth: "1980-04-26", place_of_birth: "Panama City, Panama", credits: 46, biography: "Jordana Brewster (born April 26, 1980) is an American actress. She began her actor career with an appearance in the soap opera All My Children (1995). After that, she joined the cast of As the World Turns (1995–2001), as a recurring role, Nikki Munson. She was later cast as one of the main characters in her first film feature film The Faculty (1998). Her role brought her to the attention of a much wider audience. She also landed a starring role in a NBC television miniseries entitled The 60s (1999). Her breakthrough role came in the action film The Fast and the Furious (2001). Other film roles include the action comedy film D.E.B.S. (2004), the horror film The Texas Chainsaw Massacre: The Beginning (2006), and the fourth and fifth films of the The Fast and the Furious film series, Fast & Furious (2009) and Fast Five (2011). She has appeared as a recurring role in the NBC television series Chuck (2008–2009).", image_filename: "jordana.jpg")
Person.create!(name: "Sung Kang", profession: "actor", gender: "male", date_of_birth: "1972-04-08", place_of_birth: "Gainesville, Georgia, USA", credits: 59, biography: "Kang was born in Gainesville, Georgia, to South Korean immigrant parents and spent his adolescence in California. He attended the University of California, Riverside. While in college he chose actor over law school, a decision which was met with disappointment from his parents due to their concerns over the lack of Asians on American television and lack of job prospects. His first major role was in Better Luck Tomorrow (2002), in which he played Han Lue, an aloof gang member and the cousin of Virgil Hu (played by Jason Tobin). He was one of the stars in The Motel, in which he played Sam Kim. He played the same character Han Lue in The Fast and the Furious film franchise, appearing in The Fast and the Furious: Tokyo Drift, Fast & Furious, Fast Five, Fast & Furious 6, and F9 as well as the short film Los Bandoleros. He also had a role in Jet Li's film War (2007), playing an FBI agent, and was featured in the movie Forbidden Warrior as Doran, a son of Genghis Khan. He had a small role in the action movie Live Free or Die Hard, and he appeared in Walter Hill's movie Bullet to the Head (2013) as Detective Taylor Kwon, opposite Sylvester Stallone. Kang has had several notable television roles, including the recurring role of the narcissistic President Gin Kew Yun Chun Yew Nee in the Korean drama parody 'Tae Do (Attitudes and Feelings, Both Desirable and Sometimes Secretive)' alongside Bobby Lee on MADtv. He portrayed FBI Agent Tae Kim in the short-lived crime procedural Gang Related on FOX. Both roles required him to speak Korean, which he is conversant in. The character Tae Kim was written specifically for him by creator Chris Morgan, who had worked on the Fast & Furious film franchise.", image_filename: "sung.jpg")
Person.create!(name: "Jason Momoa", profession: "actor", gender: "1979-08-01", date_of_birth: "1979-08-01", place_of_birth: "Honolulu, Hawaii, USA", credits: 61, biography: "Joseph Jason Namakaeha Momoa (born August 1, 1979) is an American actor and filmmaker. He made his actor debut as Jason Ioane on the syndicated action drama series Baywatch: Hawaii (1999–2001), which was followed by his portrayal of Ronon Dex on the Syfy science fiction series Stargate Atlantis (2005–2009), Khal Drogo in the first two seasons of the HBO fantasy drama series Game of Thrones (2011–2012), Declan Harp on the Discovery Channel historical drama series Frontier (2016–2018), and Baba Voss on the Apple TV+ science fiction series See (2019–present). Momoa was featured as the lead of the two lattermost series. Since 2016, Momoa portrays Arthur Curry / Aquaman in the DC Extended Universe (DCEU), headlining the eponymous 2018 film and its 2023 sequel. Momoa also played Duncan Idaho in the 2021 film adaptation of the science fiction novel Dune. Description above from the Wikipedia article Jason Momoa, licensed under CC-BY-SA, full list of contributors on Wikipedia.", image_filename: "jason.jpg")
Person.create!(name: "Nicole Kidman", profession: "actor", gender: "1967-06-20", date_of_birth: "1967-06-20", place_of_birth: "Honolulu, Hawaii, USA", credits: 154, biography: "Nicole Mary Kidman AC (born 20 June 1967) is an American-Australian actress and producer. Known for her work across various film and television productions from several genres, she has consistently ranked among the world's highest-paid actresses. She is the recipient of numerous accolades, including an Academy Award, a British Academy Film Award, two Primetime Emmy Awards and six Golden Globe Awards. Kidman began her actor career in Australia with the 1983 films Bush Christmas and BMX Bandits. Her breakthrough came in 1989 with the thriller film Dead Calm and the miniseries Bangkok Hilton. In 1990, she achieved international success with the action film Days of Thunder. She received greater recognition with lead roles in Far and Away (1992), Batman Forever (1995), To Die For (1995) and Eyes Wide Shut (1999). For her portrayal of writer Virginia Woolf in the drama The Hours (2002), Kidman won the Academy Award for Best Actress. She received additional Academy Award nominations for her roles in the musical Moulin Rouge! (2001) and the dramas Rabbit Hole (2010), Lion (2016) and Being the Ricardos (2021). Kidman's television roles include Hemingway & Gellhorn (2012), Big Little Lies (2017–2019), Top of the Lake: China Girl (2017), The Undoing (2020) and Nine Perfect Strangers (2021). For Big Little Lies, she received two Primetime Emmy Awards, one for Outstanding Lead Actress and the other for Outstanding Limited Series as an executive producer. Kidman has served as a Goodwill Ambassador for UNICEF since 1994 and for UNIFEM since 2006. In 2006, she was appointed Companion of the Order of Australia. She was married to actor Tom Cruise from 1990 to 2001 and has been married to country music singer Keith Urban since 2006. In 2010, she founded the production company Blossom Films. In 2004 and 2018, Time magazine included her on its list of the 100 most influential people in the world, and in 2020, The New York Times named her one of the greatest actors of the 21st century. Description above from the Wikipedia article Nicole Kidman, licensed under CC-BY-SA, full list of contributors on Wikipedia.", image_filename: "nicole.jpg")
Person.create!(name: "Christopher Eccleston", profession: "actor", gender: "male", date_of_birth: "1964-02-16", place_of_birth: "Salford, Lancashire, England, UK", credits: 107, biography: "An English stage, film and television actor. His films include Let Him Have It, Shallow Grave, Elizabeth, 28 Days Later, Gone in 60 Seconds, The Others, and G.I. Joe: The Rise of Cobra. In 2005, he became the ninth incarnation of The Doctor in the British television series Doctor Who. Description above from the Wikipedia article Christopher Eccleston, licensed under CC-BY-SA, full list of contributors on Wikipedia.", image_filename: "christopher.jpg")
Person.create!(name: "Alakina Mann", profession: "actor", gender: "female", date_of_birth: "1990-08-01", place_of_birth: "Surrey, England, UK", credits: 3, biography: "From Wikipedia, the free encyclopedia. Alakina Mann (born 1 August 1990) is an English actress. She has had a few roles, such as playing Anne in The Others and also appeared in the 2003 movie Girl with a Pearl Earring as Cornelia Vermeer. She also appeared in the television interpretation of Fungus the Bogeyman. Description above from the Wikipedia article Alakina Mann, licensed under CC-BY-SA, full list of contributors on Wikipedia.", image_filename: "alakina.jpg")
Person.create!(name: "James Bentley", profession: "actor", gender: "male", date_of_birth: "1992-07-14 ", credits: 5, biography: "From Wikipedia, the free encyclopedia. James Bentley is an actor who won a Young Artist Award for playing Nicholas Stewart in the 2001 psychological horror film The Others. In 2004, Bentley played Michael Sellers in The Life and Death of Peter Sellers, Young Nero in Imperium: Nero and a double for John Sessions in Stella Street. Bentley won the Nottingham New Theatre award for Best Actor in a Leading Role in 2013. He found further success in 2014 when he won the award for a second time running. In 2015 he became a fellow of the aforementioned theatre. He is currently a backstage manager, his most previous engagement being 'Half a Sixpence'. Description above from the Wikipedia article James Bentley, licensed under CC-BY-SA, full list of contributors on Wikipedia.", image_filename: "james.jpg")
Person.create!(name: "Fionnula Flanagan", profession: "actor", gender: "female", date_of_birth: "1941-12-10", place_of_birth: "Dublin, Ireland", credits: 112, biography: "From Wikipedia, the free encyclopedia. Fionnghuala Manon Flanagan (born 10 December 1941) is an Irish actress who has worked extensively in theatre, film and television.", image_filename: "fionnula.jpg")
Person.create!(name: "Eric Sykes", profession: "actor", gender: "male", date_of_birth: "1923-05-04", place_of_birth: "Oldham, Lancashire, England, UK", credits: 53, biography: "'Eric Sykes' started as a radio scriptwriter but he soon found he could perform as well as write. The slight handicap of being very hard of hearing doesn't interfere with his wonderful comic timing. The spectacles he wears have no lenses but contain a bone conducting hearing aid.", image_filename: "eric.jpg")
Person.create!(name: "Elaine Cassidy", profession: "actor", gender: "female", date_of_birth: "1979-12-31", place_of_birth: "Kilcoole, Wicklow, Ireland", credits: 31, biography: "Elaine Cassidy (born December 31, 1979) is an Irish actress best known for Harper's Island, Felicia's Journey, Disco Pigs and The Others.", image_filename: "elaine.jpg")
Person.create!(name: "Renée Asherson", profession: "actor", gender: "female", date_of_birth: "1915-05-19", place_of_birth: "Kensington, London, England, UK", credits: 36, biography: "Dorothy Renée Ascherson, known professionally as Renée Asherson, was an English actress. Much of her theatrical career was spent in Shakespearean plays, appearing at such venues as the Old Vic, the Liverpool Playhouse, and the Westminster Theatre. Her first stage appearance was on 17 October 1935, aged 20, and her first major film appearance was in The Way Ahead (1944). Her last film appearance was in The Others (2001).", image_filename: "renee.jpg")
Person.create!(name: "Justin Lin", profession: "Directing", gender: "male", date_of_birth: "1971-10-11", place_of_birth: "Taipei, Taiwan", credits: 35, biography: "Justin Lin is a Taiwanese-American film director whose films have grossed $2 billion worldwide. He is best known for his work on Better Luck Tomorrow (2002), The Fast and the Furious: Tokyo Drift (2006), Fast & Furious (2009), Fast Five (2011), Fast & Furious 6 (2013), F9 (2021), and Star Trek Beyond (2016). He is also known for his work on television shows like Community and the second season of True Detective. Lin was born in Taipei, Taiwan, and grew up in a working-class neighborhood in Cypress, California, in Orange County. He attended Cypress High School and University of California, San Diego for two years before transferring to UCLA, where he earned a B.A. in Film & Television and a MFA in Film Directing & Production from the UCLA film school.")
Person.create!(name: "Dan Mazeau", profession: "Writing", gender: "male", date_of_birth: "", place_of_birth: "", credits: 6, biography: "")
Person.create!(name: "Gary Scott Thompson", profession: "Writing", gender: "male", date_of_birth: "1959-10-07", place_of_birth: "Pago Pago, American Samoa", credits: 30, biography: "Gary Scott Thompson is the show runner and executive producer of the reinvented 1980s classic, 'Knight Rider'. The creator and executive producer of NBC's hit series 'Las Vegas', Thompson was also the writer of 'The Fast and the Furious'. Spending much of his childhood in American Samoa, Thompson first gained exposure to the world of entertainment as an actor, studying the craft from such notable actors as Powers Boothe. Eventually settling on writing, he received a Master of Fine Arts degree from New York University and went to work as a playwright. Thompson's theater credits include 'Small Town Syndrome,' 'Cowboy's Don't Cry' and 'Private Hells.' His feature credits include 'The Fast and the Furious' starring Vin Diesel, the sequel '2 Fast 2 Furious,' 'Hollow Man' with Kevin Bacon, and the cult classic 'Split Second', and '88 Minutes,' starring Al Pacino. Thompson resides in Los Angeles.")
Person.create!(name: "Louis Leterrier", profession: "Directing", gender: "male", date_of_birth: "1973-06-17", place_of_birth: "Paris, France", credits: 24, biography: "Louis Leterrier (born June 17, 1973) is a French film director whose notable films include The Transporter 2, Unleashed (2005), The Incredible Hulk (2008) and Clash of the Titans (2010). Description above from the Wikipedia article Louis Leterrier, licensed under CC-BY-SA, full list of contributors on Wikipedia")
Person.create!(name: "Zach Dean", profession: "Writing", gender: "male", date_of_birth: "", place_of_birth: "Michigan, USA", credits: 9, biography: "Zach Dean is an American screenwriter and film producer, best known for writing the films Deadfall and The Tomorrow War.")
Person.create!(name: "Alejandro Amenábar", profession: "Writing", gender: "male", date_of_birth: "1972-03-31", place_of_birth: "Santiago de Chile, Chile", credits: 17, biography: "From Wikipedia, the free encyclopedia.  Alejandro Fernando Amenábar Cantos (born 31 March 1972) is a Spanish film director. Amenábar was born in Santiago, Chile to a Spanish mother and Chilean father, but the family moved to Spain just one year after his birth. He studied cinema at Madrid's Universidad Complutense but eventually dropped out.  In addition to writing and directing his own films, Amenábar has maintained a notable career as a composer of film scores, including the Goya Awards-nominated score for José Luis Cuerda's La lengua de las mariposas.  Amenábar was awarded the Grand Prix of the Jury at the International Venice Film Festival in 2004 for Mar adentro ('The Sea Inside'), and in February 2005 the same film won the Academy Award for Best Foreign Language Film.  In February 2004, Amenábar came out to the Spanish gay magazine Shangay Express.  Amenábar shot in 2008 an epic film called Ágora which he wrote with Mateo Gil. The film is set in Roman Egypt and is based on the life of philosopher and mathematician Hypatia of Alexandria.  Description above from the Wikipedia article Alejandro Amenábar, licensed under CC-BY-SA, full list of contributors on Wikipedia.")
Person.create!(name: "Henry James", profession: "Writing", gender: "male", date_of_birth: "1843-04-15", place_of_birth: "New York, New York City, USA", credits: 56, biography: "Henry James, OM (15 April 1843 – 28 February 1916) was an American-born British writer, regarded as one of the key figures of 19th-century literary realism. James alternated between America and Europe for the first 20 years of his life, after which he settled in England, becoming a British subject in 1915, one year before his death. He is primarily known for the series of novels in which he portrays the encounter of Americans with Europe and Europeans. (From Wikipedia, the free encyclopedia)")

Person.create!(name: "Leonardo DiCaprio",
               profession: "actor",
               gender: "male",
               date_of_birth: "1974-11-11",
               place_of_birth: "Los Angeles, California, USA",
               credits: 142,
               image_filename: "leonardo_dicaprio.jpg",
               biography: %{Leonardo Wilhelm DiCaprio (born November 11, 1974) is an American actor and film producer. Known for his work in biopics and period films, DiCaprio is the recipient of numerous accolades, including an Academy Award, a British Academy Film Award, and three Golden Globe Awards. As of 2019, his films have grossed over $7.2 billion worldwide, and he has been placed eight times in annual rankings of the world's highest-paid actors.

Born in Los Angeles, DiCaprio began his career in the late 1980s by appearing in television commercials. In the early 1990s, he had recurring roles in various television shows, such as the sitcom Parenthood, and had his first major film part as author Tobias Wolff in This Boy's Life (1993). At age 19, he received critical acclaim and his first Academy Award and Golden Globe Award nominations for his performance as a developmentally disabled boy in What's Eating Gilbert Grape (1993). He achieved international stardom with the star-crossed romances Romeo + Juliet (1996) and Titanic (1997).

After the latter became the highest-grossing film at the time, he reduced his workload for a few years. In an attempt to shed his image of a romantic hero, DiCaprio sought roles in other genres, including crime drama in Catch Me If You Can (2002) and Gangs of New York (2002); the latter marked the first of his many successful collaborations with director Martin Scorsese. DiCaprio portrayed Howard Hughes in The Aviator (2004) and received acclaim for his performances in the political thriller Blood Diamond (2006), the crime drama The Departed (2006), and the romantic drama Revolutionary Road (2008).

In the following decade, DiCaprio starred in several high-profile directors' projects, including the science fiction thriller Inception (2010), the western Django Unchained (2012), the biopic The Wolf of Wall Street (2013), the survival drama The Revenant (2015), for which he won an Academy Award and a BAFTA Award for Best Actor in a Leading Role, and the comedy-drama Once Upon a Time in Hollywood (2019), all of which were critical and commercial successes.

DiCaprio is the founder of Appian Way Productions, a production company that has produced some of his films and the documentary series Greensburg (2008–2010), and the Leonardo DiCaprio Foundation, a nonprofit organization devoted to promoting environmental awareness. He regularly supports charitable causes and has produced several documentaries on the environment. In 2005, he was named a Commander of the Ordre des Arts et des Lettres for his contributions to the arts, and in 2016, he appeared in Time magazine's 100 most influential people in the world.}
)

Person.create!(name: "Mark Ruffalo",
               profession: "actor",
               gender: "male",
               date_of_birth: "1967-11-22",
               place_of_birth: "Los Angeles, California, USA",
               credits: 109,
               image_filename: "mark_ruffalo.jpg",
               biography: %{Mark Alan Ruffalo (born November 22, 1967) is an American actor and producer. He began actor in the early 1990s and first gained recognition for his work in Kenneth Lonergan's play This Is Our Youth (1998) and drama film You Can Count on Me (2000). He went on to star in the romantic comedies 13 Going on 30 (2004) and Just like Heaven (2005) and the thrillers In the Cut (2003), Zodiac (2007) and Shutter Island (2010). He received a Tony Award nomination for his supporting role in the Broadway revival of Awake and Sing! in 2006. Ruffalo gained international recognition for playing Bruce Banner / Hulk in superhero films set in the Marvel Cinematic Universe, including The Avengers (2012), Avengers: Infinity War (2018), and Avengers: Endgame (2019).

Ruffalo gained nominations for the Academy Award for Best Supporting Actor for playing a sperm-donor in the comedy-drama The Kids Are All Right (2010), Dave Schultz in the biopic Foxcatcher (2014), and Michael Rezendes in the drama Spotlight (2015). He won the Screen Actors Guild Award for Best Actor in a TV Movie for playing a gay writer and activist in the television drama film The Normal Heart (2015), and the Primetime Emmy Award for Outstanding Lead Actor in a Limited Series or Movie for his dual role as identical twins in the miniseries I Know This Much Is True (2020). Ruffalo is one of the few performers to receive all four EGOT nominations.}
)

Person.create!(name: "Ben Kingsley",
               profession: "actor",
               gender: "male",
               date_of_birth: "1943-12-31",
               place_of_birth: "Snainton, North Riding of Yorkshire, England, UK",
               credits: 180,
               image_filename: "ben_kingsley.jpg",
               biography: %{Sir Ben Kingsley (born Krishna Pandit Bhanji; 31 December 1943) is an English actor. He has received various accolades throughout his career spanning five decades, including an Academy Award, a British Academy Film Award, a Grammy Award, and two Golden Globe Awards. Kingsley was appointed Knight Bachelor in 2002 for services to the British film industry. In 2010, he was awarded a star on the Hollywood Walk of Fame. In 2013, he received the Britannia Award for Worldwide Contribution to Filmed Entertainment.

Description above from the Wikipedia article Ben Kingsley, licensed under CC-BY-SA, full list of contributors on Wikipedia.}
)

Person.create!(name: "Michelle Williams",
               profession: "actor",
               gender: "female",
               date_of_birth: "1980-09-09",
               place_of_birth: "Kalispell, Montana, USA",
               credits: 142,
               image_filename: "michelle_williams.jpg",
               biography: %{Michelle Ingrid Williams (born September 9, 1980) is an American actress. Known primarily for starring in small-scale independent films with dark or tragic themes, she has received various accolades, including two Golden Globe Awards and a Primetime Emmy Award, in addition to nominations for five Academy Awards and a Tony Award.

Williams, a daughter of politician and trader Larry R. Williams, began her career with television guest appearances and made her film debut in the family film Lassie in 1994. She gained emancipation from her parents at age fifteen, and soon achieved recognition for her leading role in the teen drama television series Dawson's Creek (1998–2003). This was followed by low-profile films, before having her breakthrough with the drama film Brokeback Mountain (2005).

Williams went on to receive critical acclaim for playing emotionally troubled women coping with loss or loneliness in the independent dramas Wendy and Lucy (2008), Blue Valentine (2010), and Manchester by the Sea (2016). She won two Golden Globes for portraying Marilyn Monroe in the drama My Week with Marilyn (2011) and Gwen Verdon in the miniseries Fosse/Verdon (2019), in addition to a Primetime Emmy Award for the latter. Her highest-grossing releases came with the thriller Shutter Island (2010), the fantasy film Oz the Great and Powerful (2013), the musical The Greatest Showman (2017), and the superhero films Venom (2018) and Venom: Let There Be Carnage (2021). Williams has also led major studio films, such as Ridley Scott's crime thriller All the Money in the World (2017) and Steven Spielberg's drama The Fabelmans (2022).

On Broadway, Williams starred in revivals of the musical Cabaret in 2014 and the drama Blackbird in 2016, for which she received a nomination for the Tony Award for Best Actress in a Play. She is an advocate for equal pay in the workplace. Consistently private about her personal life, Williams has a daughter from her relationship with actor Heath Ledger and was briefly married to musician Phil Elverum. She has two children with her second husband, theater director Thomas Kail.}
)

Person.create!(name: "Emily Mortimer",
               profession: "actor",
               gender: "female",
               date_of_birth: "1971-12-01",
               place_of_birth: "London, England, UK",
               credits: 84,
               image_filename: "emily_mortimer.jpg",
               biography: %{Emily Kathleen A. Mortimer (born 1 December 1971) is an English actress. She began performing on stage, and has since appeared in several film and television roles, including Scream 3, Match Point, Lars and the Real Girl, and Shutter Island.}
)

Person.create!(name: "Patricia Clarkson",
               profession: "actor",
               gender: "female",
               date_of_birth: "1959-12-29",
               place_of_birth: "New Orleans, Louisiana, USA",
               credits: 114,
               image_filename: "patricia_clarkson.jpg",
               biography: %{Patricia Davies Clarkson (born December 29, 1959) is an American actress. After studying drama on the East Coast, Clarkson launched her actor career in 1985, and has worked steadily in both film and television. She twice won the Emmy for Outstanding Guest Actress in Six Feet Under. Film roles included The Green Mile, Far From Heaven, The Station Agent and was nominated for an Academy Award for Best Supporting Actress for her performance in Pieces of April (2003).

Description above from the Wikipedia article Patricia Clarkson, licensed under CC-BY-SA, full list of contributors on Wikipedia.}
)

Person.create!(name: "Max von Sydow",
               profession: "actor",
               gender: "male",
               date_of_birth: "2020-03-08",
               place_of_birth: "Lund, Skåne län, Sweden",
               credits: 178,
               image_filename: "max_von_sydow.jpg",
               biography: %{Max von Sydow (10 April 1929 – 8 March 2020) was a Swedish actor. He also held French citizenship since 2002. He starred in many films and had supporting roles in dozens more. He performed in films filmed in many languages, including Swedish, Norwegian, English, Italian, German, Danish, French and Spanish.

Some of his most memorable film roles include knight Antonius Block in Ingmar Bergman's The Seventh Seal (the first of his eleven films with Bergman and the film that includes the iconic shot of his career in the scene where he plays chess with Death), Jesus in George Stevens's The Greatest Story Ever Told, Father Merrin in Friedkin's The Exorcist, Joubert the assassin in Three Days of the Condor, and Ming the Merciless in the 1980 version of Flash Gordon.

He was twice nominated for the Academy Award - Best Leading Actor for Pelle the Conqueror (1988) and Best Supporting Actor for Extremely Loud and Incredibly Close (2011).}
)

Person.create!(name: "Jackie Earle Haley",
               profession: "actor",
               gender: "male",
               date_of_birth: "1961-07-14",
               place_of_birth: "Northridge, California, USA",
               credits: 64,
               image_filename: "jackie_earle_haley.jpg",
               biography: %{Jackie Earle Haley (born Jack E. Haley; July 14, 1961) is an American film actor. Establishing himself from child actor to adult Academy Award-nominee, he is perhaps best known for his roles as Moocher in Breaking Away, Kelly Leak in The Bad News Bears, pedophile Ronnie McGorvey in Little Children, the vigilante Rorschach in Watchmen, as horror icon Freddy Krueger in the remake of A Nightmare on Elm Street, released on April 30, 2010, and most recently as Guerrero in Fox's drama Human Target.

Description above from the Wikipedia article Jackie Earle Haley, licensed under CC-BY-SA, full list of contributors on Wikipedia​}
)

Person.create!(name: "John Carroll Lynch",
               profession: "actor",
               gender: "male",
               date_of_birth: "1963-08-01",
               place_of_birth: "Boulder, Colorado, USA",
               credits: 106,
               image_filename: "john_carroll_lynch.jpg",
               biography: %{John Carroll Lynch (born August 1, 1963) is an American actor, known for his role as Drew Carey's cross-dressing brother on The Drew Carey Show, and for his role as Norm, the unassuming husband of Margie Gunderson (Frances McDormand) in Fargo.

In the fall of 2003, he starred in the CBS show The Brotherhood of Poland, New Hampshire, with Randy Quaid, Chris Penn, Mare Winningham, Elizabeth McGovern, and Ann Cusack. The show was cancelled after only a few episodes. He also had a recurring role in the HBO show Carnivàle, playing escaped convict Varlyn Stroud. Lynch appeared as a district attorney in the CBS series Close to Home and as NASA official Bob Gilruth in the HBO mini-series From the Earth to the Moon. Lynch appeared in the 2003 thriller Gothika and the 2007 biopic Zodiac.}
)

Person.create!(name: "Martin Scorsese",
               profession: "Martin Scorsese",
               gender: "male",
               date_of_birth: "1942-11-17",
               place_of_birth: "Queens, New York, USA",
               credits: 345,
               biography: %{Martin Charles Scorsese (born November 17, 1942) is an American film director, producer, screenwriter, and actor. One of the major figures of the New Hollywood era, he is widely regarded as one of the greatest and most influential directors in film history. Scorsese's body of work explores themes such as Italian-American identity, Catholic concepts of guilt and redemption, faith, machismo, nihilism, crime and sectarianism. Many of his films are known for their depiction of violence and the liberal use of profanity. Scorsese has also dedicated his life to film preservation and film restoration by founding the nonprofit organization The Film Foundation in 1990, as well as the World Cinema Foundation in 2007 and the African Film Heritage Project in 2017.

Scorsese studied at New York University (NYU), where he received a bachelor's degree in English literature in 1964, and received a master's degree in fine arts in film from NYU's Tisch School of the Arts in 1968. In 1967 Scorsese's first feature film Who's That Knocking at My Door was released and was accepted into the Chicago Film Festival, where critic Roger Ebert saw it and called it "a marvelous evocation of American city life, announcing the arrival of an important new director".

He has established a filmmaking history involving repeat collaborations with actors and film technicians, including nine films made with Robert De Niro. His films with De Niro are the psychological thriller Taxi Driver (1976), the biographical sports drama Raging Bull (1980), the satirical black comedy The King of Comedy (1982), the musical drama New York, New York (1977), the psychological thriller Cape Fear (1991), and the crime films Mean Streets (1973), Goodfellas (1990), Casino (1995) and The Irishman (2019). Scorsese has also been noted for his collaborations with actor Leonardo DiCaprio, having directed him in five films: the historical epic Gangs of New York (2002), the Howard Hughes biography The Aviator (2004), the crime thriller The Departed (2006), the psychological thriller Shutter Island (2010), and the Wall Street black comedy The Wolf of Wall Street (2013). The Departed won Scorsese an Academy Award for Best Director, and for Best Picture. Scorsese is also known for his long-time collaboration with film editor Thelma Schoonmaker, who has edited every Scorsese film beginning with Raging Bull. Scorsese's other film work includes the black comedy After Hours (1985), the romantic drama The Age of Innocence (1993), the children's adventure drama Hugo (2011), and the religious epics The Last Temptation of Christ (1988), Kundun (1997) and Silence (2016).}
)

Person.create!(name: "Dennis Lehane",
               profession: "Writing",
               gender: "male",
               date_of_birth: "1965-08-04",
               place_of_birth: "Dorchester, Boston, Massachusetts, USA",
               credits: 18,
               biography: %{From Wikipedia, the free encyclopedia.

Dennis Lehane (born August 4, 1965) is an American author. He has written several award-winning novels, including A Drink Before the War and the New York Times bestseller Mystic River, which was later made into an Academy Award-winning film. Another novel, Gone, Baby, Gone, was also adapted into an Academy Award-nominated film. His novel Shutter Island was adapted into a film by Martin Scorsese in 2010. Lehane is a graduate of Florida International University in Miami, Florida.

Description above from the Wikipedia article Dennis Lehane, licensed under CC-BY-SA, full list of contributors on Wikipedia}
)

Person.create!(name: "Laeta Kalogridis",
               profession: "Writing",
               gender: "female",
               date_of_birth: "1965-08-30",
               credits: 17,
               biography: %{Laeta Elizabeth Kalogridis is a screenwriter. She is a graduate of Davidson College in Davidson, NC and University of Texas at Austin and attended UCLA's prestigious film school.

She has written scripts for Alexander (2004), Night Watch (2006 in U.S.), Pathfinder (2007) and Shutter Island (2010). She has also served as an executive producer for the television series Birds of Prey and Bionic Woman.

She is also the founder of the pro-union website Hollywood United and was involved as a peacemaker in the 2007–2008 Writers Guild of America strike.}
)

# 37

Person.create!(name: "John Travolta",
               profession: "actor",
               gender: "male",
               date_of_birth: "1954-02-18",
               place_of_birth: "Englewood, New Jersey, USA",
               credits: 151,
               image_filename: "john_travolta.jpg",
               biography: %{An American actor, film producer, dancer, and singer. He first became known in the 1970s, after appearing on the television series Welcome Back, Kotter and starring in the box office successes Saturday Night Fever and Grease. Travolta's career re-surged in the 1990s, with his role in Pulp Fiction, and he has since continued starring in Hollywood films, including Face/Off, Ladder 49 and Wild Hogs. Travolta has twice been nominated for the Academy Award for Best Actor. The first, for his role in Saturday Night Fever and the second for Pulp Fiction. He won the Golden Globe Award for Best Actor - Motion Picture Musical or Comedy for his performance in Get Shorty.

Travolta, the youngest of six children, was born and raised in Englewood, New Jersey, an inner-ring suburb of New York City. His father, Salvatore Travolta, was a semi-professional football player turned tire salesman and partner in a tire company. His mother, Helen Cecilia, was an actress and singer who had appeared in The Sunshine Sisters, a radio vocal group, and acted and directed before becoming a high school drama and English teacher. His siblings are Joey, Ellen, Ann, Margaret, and Sam Travolta. Travolta's father was a second-generation Italian American and his mother was Irish American; he grew up in an Irish-American neighborhood and has said that his household was predominantly Irish in culture. His family was Roman Catholic.

Travolta married actress Kelly Preston in 1991. The couple had a son, Jett, (April 13, 1992 - January 2, 2009), and have a daughter, Ella Bleu, born in 2000. On May 18, 2010, Travolta and Preston announced that she is pregnant with the couple's third child. The couple has regularly attended marriage counselling, and Travolta admits that therapy has helped the marriage. Travolta was involved with actress Diana Hyland, whom he met while filming The Boy in the Plastic Bubble; the relationship ended when she died of breast cancer in 1977.

Travolta is a certified pilot and owns five aircraft, including an ex-Australian Boeing 707–138 airliner. The plane bears the name Jett Clipper Ella in honor of his children. His $4.9 million estate in the Jumbolair subdivision in Ocala, Florida, is situated on Greystone Airport with its own runway and taxiway right to his front door.

Travolta has been a practitioner of Scientology since 1975 when he was given the book Dianetics while filming the movie The Devil's Rain in Durango, Mexico.}
)

Person.create!(name: "Nicolas Cage",
               profession: "actor",
               gender: "male",
               date_of_birth: "1964-01-07",
               place_of_birth: "Long Beach, California, USA",
               credits: 162,
               image_filename: "nicolas_cage.jpg",
               biography: %{Nicolas Cage (born Nicolas Kim Coppola) is an American actor and filmmaker; he is also nephew to Francis Ford Coppola. He is the recipient of various accolades, including an Academy Award, a Screen Actors Guild Award, and a Golden Globe Award.

During the early years of his career, Cage starred in a variety of films such as Rumble Fish (1983), Racing with the Moon (1984), Peggy Sue Got Married (1986), Raising Arizona (1987), Vampire's Kiss (1989), Wild at Heart (1990), Honeymoon in Vegas (1992), and Red Rock West (1993). During this period, John Willis' Screen World, Vol. 36 listed him as one of twelve Promising New Actors of 1984.

For his performance in Leaving Las Vegas (1995), he won the Academy Award for Best Actor. He received his second Academy Award nomination for his performance as Charlie and Donald Kaufman in Adaptation (2002). He subsequently appeared in more mainstream films, such as The Rock (1996), Con Air (1997), City of Angels (1998), 8mm (1999), Windtalkers (2002), Lord of War (2005), The Wicker Man (2006), Bangkok Dangerous (2008) and Knowing (2009).

He also directed the film Sonny (2002), for which he was nominated for Grand Special Prize at Deauville Film Festival. Cage owns the production company Saturn Films and has produced films such as Shadow of the Vampire (2000) and The Life of David Gale (2003). In October 1997, Cage was ranked No. 40 in Empire magazine's The Top 100 Movie Stars of All Time list, while the next year, he was placed No. 37 in Premiere's 100 most powerful people in Hollywood.

In the 2010s, he starred in Kick-Ass (2010), Drive Angry (2011), Joe (2013), The Runner (2015), Dog Eat Dog (2016), Mom and Dad (2017), Mandy (2018), Spider-Man: Into the Spider-Verse (2018), and Color Out of Space (2019). His participation in various film genres during this time increased his popularity and gained him a cult following.}
)

Person.create!(name: "Joan Allen",
               profession: "actor",
               gender: "female",
               date_of_birth: "1956-08-20",
               place_of_birth: "Rochelle, Illinois, USA",
               credits: 63,
               image_filename: "joan_allen.jpg",
               biography: "Joan Allen (born August 20, 1956) is an American actress. She worked in theatre, television and film during her early career, and achieved recognition for her Broadway debut in Burn This, winning a Tony Award for Best Performance by a Leading Actress in a Play in 1989.

She has received three Academy Award nominations; she was nominated for Best Supporting Actress for Nixon (1995) and The Crucible (1996), and for Best Actress for The Contender (2000).

Her other films include The Ice Storm (1996), Face/Off (1997), Pleasantville (1998), The Notebook (2004), The Bourne Supremacy (2004) and The Bourne Ultimatum (2007)."
)
Person.create!(name: "Alessandro Nivola",
               profession: "actor",
               gender: "male",
               date_of_birth: "1972-06-28",
               place_of_birth: "Boston, Massachusetts, USA",
               credits: 62,
               image_filename: "alessandro_nivola.jpg",
               biography: "Alessandro Antine Nivola (born June 28, 1972) is an American actor, perhaps best known for his roles in the films Best Laid Plans, Jurassic Park III, Face/Off, and the first two films of the Goal! trilogy."
)
Person.create!(name: "Gina Gershon",
               profession: "actor",
               gender: "female",
               date_of_birth: "1962-06-10",
               place_of_birth: "San Fernando Valley, California, USA",
               credits: 140,
               image_filename: "gina_gershon.jpg",
               biography: "Gina L. Gershon (born June 10, 1962) is an American film, television and stage actress, singer and author. She is known for her roles in the films Cocktail (1988), Showgirls (1995), Bound (1996), Face/Off (1997), The Insider (1999), Demonlover (2002), P.S. I Love You (2007), Five Minarets in New York (2010), Killer Joe (2011) and House of Versace (2013). She has also had supporting roles in FX's Rescue Me and HBO's How to Make It in America."
)

Person.create!(name: "Dominique Swain",
               profession: "actor",
               gender: "female",
               date_of_birth: "1980-08-12",
               place_of_birth: "Malibu, California, USA",
               credits: 88,
               image_filename: "dominique_swain.jpg",
               biography: %{Dominique Ariane Swain (born August 12, 1980) is an American actress. She is best known for her roles as the title character in the 1997 film adaptation of Vladimir Nabokov's novel Lolita, and as Jamie Archer in the film Face/Off.

Swain started her career in Hollywood as a stunt double; she appeared as the double for Macaulay Culkin's younger sister Quinn in Joseph Ruben's The Good Son (1993). In 1995, at the age of 14, she was chosen out of 2,500 girls to play the title role in Adrian Lyne's controversial 1997 screen adaptation of Lolita, as Dolores "Lolita" Haze. She was 15 during filming and her performance was praised by critics. She later then played the rebellious teen Jamie Archer in John Woo's Face/Off (1997). She starred in the 1998 drama film Girl, in which she plays a high-schooler who is determined to lose her virginity. In 2009, Swain appeared in Starz Inside: Sex and the Cinema which discussed the depiction of sex in film. That same year, she was featured in the movie Noble Things, about the country star Jimmy Wayne Collins, which also starred country musician Lee Ann Womack. Swain also starred in the horror/slasher film Fall Down Dead as the main character, Christie Wallace. She starred in Monte Hellman's romance thriller Road to Nowhere in 2010. In 2011, Swain was featured in David Ren's action thriller The Girl from the Naked Eye. She starred in the direct-to-video science fiction film Nazis at the Center of the Earth in 2012. In 2013, Swain starred in Gregory Hatanaka's drama film Blue Dream as Gena Townsend.

From Wikipedia, the free encyclopedia}
)
Person.create!(name: "Nick Cassavetes",
               profession: "actor",
               gender: "male",
               date_of_birth: "1959-05-21",
               place_of_birth: "New York City, New York, USA",
               credits: 56,
               image_filename: "nick_cassavetes.jpg",
               biography: %{Nicholas David Rowland Cassavetes is an American film actor, director, producer, screenwriter, and filmmaker. He is the son of actress Gena Rowland and director John Cassavetes.

His actor credits include an uncredited role in Husbands (1970)—which was directed by his father, John Cassavetes—as well as roles in the films The Wraith (1986), Face/Off (1997), and Blow (2001).

He has directed such films as She's So Lovely, John Q., The Notebook, Alpha Dog, and My Sister's Keeper.}
)
Person.create!(name: "Harve Presnell",
               profession: "actor",
               gender: "male",
               date_of_birth: "1933-09-14",
               place_of_birth: "Modesto, California, USA",
               credits: 56,
               image_filename: "harve_presnell.jpg",
               biography: %{Harve Presnell (September 14, 1933 – June 30, 2009) was an American actor and singer. He began his career in the mid 1950s as a classical baritone, singing with orchestras and opera companies throughout the United States. His career reoriented away from classical music to musical theatre in 1960 after Meredith Willson cast him in the lead role of his new Broadway musical The Unsinkable Molly Brown. His portrayal of "Leadville Johnny" was a resounding success and he reprised the role in the 1964 film version of the musical, winning a Golden Globe Award for his portrayal.

Presnell went on to star in a few more films during the 1960s, but by the early 1970s that aspect of his career came to a standstill. From 1970 to 1995 he mostly worked as a musical theatre performer on Broadway, the West End, and in touring productions out of New York. In his early 60s, Presnell saw a resurgence in his movie career which lasted until his death. He portrayed character roles in films like Fargo (1996), Saving Private Ryan (1998), and Flags of Our Fathers (2006). He also appeared on television as Mr. Parker in The Pretender and Lew Staziak in Andy Barker, P.I.. He had recurring roles on Lois & Clark: The New Adventures of Superman and Dawson's Creek.

Description above from the Wikipedia article Harve Presnell, licensed under CC-BY-SA, full list of contributors on Wikipedia.}
)

Person.create!(name: "Colm Feore",
               profession: "actor",
               gender: "male",
               date_of_birth: "1958-08-22",
               place_of_birth: "Boston, Massachusetts, USA",
               credits: 140,
               image_filename: "colm_feore.jpg",
               biography: %{Colm Joseph Feore OC (/ˈkɒləm ˈfjɔːr/; born August 22, 1958) is a Canadian actor. A 15-year veteran of the Stratford Festival, he is known for his Gemini-winning turn as Prime Minister Pierre Trudeau in the CBC miniseries Trudeau (2002), his portrayal of Glenn Gould in Thirty Two Short Films About Glenn Gould (1993), and for playing Detective Martin Ward in Bon Cop, Bad Cop (2006) and its sequel Bon Cop, Bad Cop 2 (2017).

His other roles include Martin Harrison in Chicago (2002), Lord Marshal Zhylaw in The Chronicles of Riddick (2004), First Gentleman Henry Taylor on 24 (2009), Cardinal Della Rovere on The Borgias (2011–2013), Laufey in Thor (2011), General Ted Brockhart on House of Cards (2016–2017), Declan Gallard on 21 Thunder (2017), Wernher von Braun in For All Mankind (2019), and Sir Reginald Hargreeves on The Umbrella Academy (2019–present). Feore is also a Prix Iris and Screen Actors Guild Award winner and a Genie Award nominee.}
)

Person.create!(name: "John Woo",
               profession: "Directing",
               gender: "male",
               date_of_birth: "1946-09-22",
               place_of_birth: "Guangzhou, China",
               credits: 96,
               biography: %{John Woo Yu-Sen SBS is a Hong Kong film director and producer. Recognized for his stylised films of highly choreographed action sequences, Mexican standoffs, and use of slow-motion, Woo has directed several notable Hong Kong action films, among them, A Better Tomorrow, The Killer, Hard Boiled and Red Cliff. His Hollywood films include Hard Target, Broken Arrow, Face/Off and Mission: Impossible 2. He also created the comic series Seven Brothers, published by Virgin Comics. Woo was described by Dave Kehr in The Observer in 2002 as "arguably the most influential director making movies today". Woo cites his three favorite films as David Lean's Lawrence of Arabia, Akira Kurosawa's Seven Samurai and Jean-Pierre Melville's Le Samouraï.}
)
Person.create!(name: "Michael Colleary",
               profession: "Writing",
               gender: "male",
               credits: 8,
               biography: %{From Wikipedia, the free encyclopedia.

Michael Colleary is an American screenwriter, film producer and television writer. His writing credits include Face/Off, Firehouse Dog, The New Alfred Hitchcock Presents and the story for Lara Croft: Tomb Raider.

He is a frequent collaborator with Mike Werb in which they won a Saturn Award for their work on Face/Off. Colleary most recently wrote for the Cartoon Network live-action series Unnatural History.

Description above from the Wikipedia article Michael Colleary, licensed under CC-BY-SA, full list of contributors on Wikipedia.}
)
Person.create!(name: "Mike Werb",
               profession: "Writing",
               gender: "male",
               credits: 13,
               biography: %{From Wikipedia, the free encyclopedia

Mike Werb is an American screenwriter, whose writing credits include Face/Off, The Mask and the story for Lara Croft: Tomb Raider.

A Los Angeles native, Werb attended Stanford. He is a UCLA Film School graduate.

His frequent collaborator is Michael Colleary. The duo won a Saturn Award for Best Writing for Face/Off in 1998. They previously worked on projects "Top Ten", "Stretch Armstrong" and "King's Ransom" (the latter one for director John Woo), but neither of these films were produced. He is the creator of Unnatural History.

Description above from the Wikipedia article Mike Werb, licensed under CC-BY-SA, full list of contributors on Wikipedia.}
)

# 49

Person.create!(name: "Nicole de Boer",
               profession: "actor",
               gender: "female",
               date_of_birth: "1970-12-20",
               place_of_birth: "Toronto, Ontario, Canada",
               credits: 49,
               image_filename: "nicole_de_boer.jpg",
               biography: "Nicole de Boer is a Canadian actress. She is known for starring in the cult film Cube as Joan Leaven, playing Ezri Dax on the final season of Star Trek: Deep Space Nine (1998–1999), and as Sarah Bannerman on the series The Dead Zone (2002–2007)."
)

Person.create!(name: "Nicky Guadagni",
               profession: "actor",
               gender: "female",
               date_of_birth: "1952-08-01",
               place_of_birth: "Montreal, Quebec, Canada",
               credits: 26,
               image_filename: "nicky_guadagni.jpg",
               biography: "Nicky Guadagni (born August 1, 1952) is a Canadian actress who has worked on stage, radio, film and television."
)

Person.create!(name: "Maurice Dean Wint",
               profession: "actor",
               gender: "male",
               date_of_birth: "1964-05-01",
               place_of_birth: "Leicestershire, England, UK",
               credits: 51,
               image_filename: "maurice_dean_wint.jpg",
               biography: "Born in Leicestershire, England, Wint immigrated to Canada 1967. Wint is a stage, screen, and voice actor best known for Cube."
)

Person.create!(name: "David Hewlett",
               profession: "actor",
               gender: "male",
               date_of_birth: "1968-04-18",
               place_of_birth: "Redhill, Surrey, England, UK",
               credits: 76,
               image_filename: "david_hewlett.jpg",
               biography: "David Ian Hewlett (born April 18, 1968) is an English-born Canadian actor best known for his role as Dr. Meredith Rodney McKay on the science fiction television shows Stargate SG1 and Stargate Atlantis."
)
Person.create!(name: "Andrew Miller",
               profession: "actor",
               gender: "male",
               date_of_birth: "1969-02-25",
               place_of_birth: "Toronto, Ontario, Canada",
               credits: 13,
               image_filename: "andrew_miller.jpg",
               biography: "Andrew Miller (born February 25, 1969) is a Canadian actor, writer, and director. He is known for his role as Kazan in the 1997 science fiction horror film Cube and for playing Creon in the 2020 PBS adaptation of Oedipus Rex."
)
Person.create!(name: "Julian Richings",
               profession: "actor",
               gender: "male",
               date_of_birth: "1955-09-08",
               place_of_birth: "Oxford, Oxfordshire, England, UK",
               credits: 140,
               image_filename: "julian_richings.jpg",
               biography: "Julian Richings (born 30 August 1956) is a British-Canadian character actor. He has appeared in over 225 films and television series."
)
Person.create!(name: "Wayne Robson",
               profession: "actor",
               gender: "male",
               date_of_birth: "2011-04-04",
               place_of_birth: "Vancouver, British Columbia, Canada",
               credits: 90,
               image_filename: "wayne_robson.jpg",
               biography: "Wayne Robson (April 29, 1946 – April 4, 2011) was a Canadian television, stage, voice and film actor known for playing the part of Mike Hamar, an ex-convict and sometime thief, on the Canadian sitcom The Red Green Show from 1993 to 2006, as well as in the 2002 film Duct Tape Forever."
)

Person.create!(name: "Vincenzo Natali",
               profession: "Writing",
               gender: "male",
               date_of_birth: "1969-01-06",
               place_of_birth: "Detroit, Michigan, USA",
               credits: 39,
               biography: %{From Wikipedia, the free encyclopedia

Vincenzo Natali (born 1969) is an American-born Canadian film director and screenwriter, known for writing and directing science fiction and horror films such as Cube, Cypher, Nothing, and Splice.

Description above from the Wikipedia article Vincenzo Natali, licensed under CC-BY-SA, full list of contributors on Wikipedia.}
)
Person.create!(name: "Graeme Manson",
               profession: "Writing",
               gender: "male",
               date_of_birth: "1963-08-01",
               place_of_birth: "Boulder, Colorado, USA",
               credits: 16,
               biography: %{Graeme Manson is a Canadian film and television writer and producer, best known as co-creator, executive producer and writer of the television series "Orphan Black".}
)
Person.create!(name: "André Bijelic",
               profession: "Writing",
               gender: "male",
               credits: 3,
               biography: %{We don't have a biography for André Bijelic.}
)

movies_and_categories = {
  'The Others' => ['horror', 'thriller', 'mystery'],
  'Fast X' => ['action', 'crime', 'thriller'],
  'Face/Off' => ['action', 'crime', 'Science fiction', 'thriller'],
  'Cube' => ['thriller', 'science fiction', 'mystery'],
  'Shutter Island' => ['drama', 'thriller', 'mystery']
}

movies_and_categories.each do |movie_title, category_names|
  movie = Movie.find_by!(title: movie_title)
  movie.categories << Category.where(name: category_names)
end

def create_movie_people(movie_id, cast)
  cast.each do |person_id, role_id, character = nil|
    MoviePerson.create!(
      movie_id: movie_id,
      person_id: person_id,
      role_id: role_id,
      character_name: character
    )
  end
end

# Movie 4: Fast & Furious 9
create_movie_people(4, [
  [1, 1, "Dominic 'Dom' Toretto"],
  [2, 1, 'Letty Ortiz'],
  [3, 1, 'Roman Pearce'],
  [4, 1, 'Tej Parker'],
  [5, 1, 'Jakob Toretto'],
  [6, 1, 'Ramsey'],
  [7, 1, 'Mia Toretto'],
  [8, 1, 'Han Lue'],
  [9, 1, 'Dante Reyes'],
  [18, 4],
  [18, 5],
  [19, 4],
  [19, 5],
  [20, 7],
  [21, 2],
  [22, 5]
])

# Movie 10: The Others
create_movie_people(10, [
  [10, 1, 'Grace Stewart'],
  [11, 1, 'Charles Stewart'],
  [12, 1, 'Anne Stewart'],
  [13, 1, 'Nicholas Stewart'],
  [14, 1, 'Mrs. Bertha Mills'],
  [15, 1, 'Mr. Edmund Tuttle'],
  [16, 1, 'Lydia'],
  [17, 1, 'Old Lady'],
  [23, 2],
  [24, 4]
])

# Movie 11: Shutter Island
create_movie_people(11, [
  [25, 1, 'Teddy Daniels'],
  [26, 1, 'Chuck Aule'],
  [27, 1, 'Dr. John Cawley'],
  [28, 1, 'Dolores Chanal'],
  [29, 1, 'Rachel Solando'],
  [30, 1, 'Rachel 2'],
  [31, 1, 'Dr. Jeremiah Naehring'],
  [32, 1, 'George Noyce'],
  [33, 1, 'Deputy Warden McPherson'],
  [34, 2],
  [35, 6],
  [36, 4]
])

# Movie 12: Face/Off
create_movie_people(12, [
  [37, 1, 'Sean Archer'],
  [38, 1, 'Castor Troy'],
  [39, 1, 'Eve Archer'],
  [40, 1, 'Pollux Troy'],
  [41, 1, 'Sasha Hassler'],
  [42, 1, 'Jamie Archer'],
  [43, 1, 'Dietrich Hassler'],
  [44, 1, 'Victor Lazarro'],
  [45, 1, 'Dr. Malcolm Walsh'],
  [46, 2],
  [47, 3],
  [48, 3]
])

# Movie 13: Cube
create_movie_people(13, [
  [49, 1, 'Leaven'],
  [50, 1, 'Holloway'],
  [51, 1, 'Quentin'],
  [52, 1, 'Worth'],
  [53, 1, 'Kazan'],
  [54, 1, 'Alderson'],
  [55, 1, 'Rennes'],
  [56, 2],
  [56, 4],
  [57, 4],
  [58, 4]
])

(1..13).each do |movie_id|
  cover_file_path = File.join(Rails.root, "public/movies/covers/#{movie_id}.jpg")
  bg_file_path = File.join(Rails.root, "public/movies/backgrounds/#{movie_id}.jpg")
  movie = Movie.find(movie_id)
  movie.cover.attach(io: File.open(cover_file_path), filename: "#{movie_id}.jpg")
  movie.background.attach(io: File.open(bg_file_path), filename: "#{movie_id}.jpg")
end

(1..55).each do |person_id|
  image_file_path = File.join(Rails.root, "public/people/#{person_id}.jpg")
  next unless File.exist?(image_file_path)
  person = Person.find(person_id)
  person.image.attach(io: File.open(image_file_path), filename: "#{person_id}.jpg")
end

keywords = [
  'new york city',
  'loss of loved one',
  'showdown',
  'secret identity',
  'hero',
  'magic',
  'villain',
  'dangerous',
  'vigilante',
  'portal',
  'sequel',
  'superhero',
  'superhero team',
  'alternate reality',
  'masked vigilante',
  'spider web',
  'aftercreditsstinger',
  'duringcreditsstinger',
  'marvel cinematic universe (mcu)',
  'teenage hero',
  'fight for justice',
  'superhero teamup',
  'returning hero',
  'crossover',
  'teamwork'
]

keywords.each do |keyword|
  Keyword.create!(name: keyword)
end

keyword_ids = (1..25).to_a
Movie.find(10).keywords << Keyword.find(keyword_ids)

# reviews

Review.create!(user_id: 1, movie_id: 12, rating: 5.0, content: %{t's like looking in a mirror, only, not.

There's a tendency to undervalue the action movie. Certainly there's a wide expanse of land in cinema world where film fans reside, where the thought of praising an action film for being "classic" cinema is considered treason against the very word. Yet some of the artistry involved in the genre's leading lights is purely sublime, regardless of how bizarre and unlikely the plot is. Enter John Woo's berserker, ear splitting, high octane actioner, Face/Off. Rightly sitting along side the likes of Die Hard and Predator as genre pieces that showcase how good things can be when it all comes together, Woo's movie is as much fun as you could wish to have for over two hours of explosive, fantastical, unadulterated cinema.

The plot sees John Travolta's serious family man cop, Sean Archer, devote his life to catching unbalanced maniacal bad guy Castor Troy (Nicolas Cage). There's some bad history between the two and when Archer manages to capture both Troy and his equally vile brother, Pollux (Alessandro Nivola), it would seem to be closure for Archer and his family. However, it's found that the Troy's have left a ticking bomb somewhere in Los Angeles, and if undetected it will flatten L.A. and kill practically everyone. So, Archer undergoes a revolutionary face-swapping procedure with the now comatose Castor and sets about getting the information from the incarcerated Pollux. But wait!, Castor wakes up and turns the tables by assuming Archer's identity, setting the wheels in motion for each man to live the others life until the Face/Off between the pair will decide their respective fate.

Unbelievable? Of course. Who cares? Well nobody should really, because surely going into a film like this one is expecting the ludicrous. Both Cage and Travolta are superbly realising the spectacular nature of the script, and being mesmerising in the duality of the roles into the bargain. Make no bones about it, Woo and his team have crafted a benchmark action movie. There's a trail of thought that suggests that Woo basically keeps making the same movie, that's a fair enough point, sure enough, all of his staple action sequences and traits are evident in Face/Off. Yet Woo has delved into his characters, given them some flesh on their action bones, and then upped the anti in action set pieces to cloak them in chaotic beauty. From the opening Jet escape/pursuit set up, to the outrageous speed boat finale, the film is one long exhilarating breath taker. Joan Allen, Gina Gershon, Dominique Swain & Nick Cassavetes all file into the background playing important characters who are rightly secondary to the protagonists, while a ream of extras come and go as each are dispatched in a hail of Woo inspired carnage. The pace never sags and the eyes and ears are treated to a vibrancy that is often sadly missing from many other big budgeted action blockbusters.

This is a masterpiece of action cinema, so even as a Orson Welles crane shot is a magnificent thing, so it be with the sight of two stunt men flailing thru the air in a spray of exploding water. Oh yes sir, this is a classic alright. 10/10})

Review.create!(user_id: 1, movie_id: 4, rating: 5.0, content: %{I can always rely on this franchise to give me what I desire from it.

'Fast X' is a great time. I adore the whole series and have done so since watching the opening entry of it as a teen, sure it has changed tremendously since those halcyonic days of 2001 (OK, I was like 5 then...) but my fondness and enjoyment of these films remains unchanged - quality entertainment!

I love the main cast, particularly those we've had since the beginning or thereabouts - from Vin Diesel and Michelle Rodriguez to Tyrese Gibson and Ludacris (I'm gonna need a spin-off with those two if you're reading, Universal!) to Sung Kang and Jordana Brewster (want more of the latter, but I get it's tricky with the absence of Paul Walker; who is still missed). I'll never tire (tyre?) of watching them together.

Away from those guys, the recurrence of the likes of Charlize Theron, John Cena and Nathalie Emmanuel is pleasant and the additions of Brie Larson and Jason Momoa are highly welcomed. I wasn't sure if Momoa was a bit too over the top in parts, but all in all he makes for a memorable antagonist - he certainly commits to the role!

The action continues to be absolutely bonkers and I continue to be absolutely onboard with everything and anything that is portrayed onscreen. The look of the film, the sound of the film... I dig it all to be honest. It's loud as heck, but that's exactly what I'd want from a 'Fast & Furious' flick. A film worth the admission fee, as usual.

Bring on 'Fast XI' or whatever they decide to call it. Apparently we're still getting another one after that, which I personally hope has its own sequel, which in turn has its sequel, followed by another seque... you get my point. I wanna be 105 and sat in the cinema watching another one of these.😂})

Review.create!(user_id: 1, movie_id: 10, rating: 5.0, content: %{Spectral happenings on an estate in the Channel Islands after WWII (no spoilers)

RELEASED IN 2001 and written & directed by Alejandro Amenábar, "The Others" is a haunted house flick about a woman (Nicole Kidman) who lives in an old manor on one of the Channel Islands with her two photosensitive children immediately after WWII. After three people arrive seeking employment, they increasingly become convinced that the abode is haunted.

While this is a fantasy movie in that it depicts supernatural happenings, like doors mysteriously opening and closing, these types of unexplainable things have been known to happen. The movie is a serious exploration of what may really be occurring. The mansion seems sterile and there’s a one-dimensional pale ‘look’ to the bulk of the picture, which was intentional for obvious reasons. Speaking of which, the perpetually fog-laden grounds create a nice ghostly ambiance.

Everything hinges on whether the last act effectively reveals the truth and it does. The film provides intriguing food for thought.

THE MOVIE RUNS 1 hour, 44 minutes and was shot in Cantabria, Spain (exteriors of the mansion); Penshurst, Kent, England (The Lime Walk) and Madrid.

GRADE: B/B-})

Review.create!(user_id: 1, movie_id: 11, rating: 5.0, content: %{Don't you get it? You're a rat in a maze.

US Marshal Teddy Daniels (Leonardo DiCaprio) travels to an island asylum facility for the criminally insane with his newly assigned partner Chuck Aule (Mark Ruffalo). Their reason for being at Ashecliff Hospital is to investigate the mysterious disappearance of murderess Rachel Solando. But Teddy has another issue to deal with at Ashecliff, namely a meeting with Andrew Laeddis (Elias Koteas), the man he believes responsible for the death of his wife (Michelle Williams). Nothing is what it seems at the facility though, and the further Teddy & Chuck investigate, the murkier the truths of Ashecliff become.

Directed by Martin Scorsese, Shutter Island is adapted from the best selling novel of the same name written by Dennis Lehane ("Mystic River/Gone Baby Gone"). It finds the talented director getting closer to horror than at any point in his career, it also finds him arguably over cooking his grits. Lehane's novel is a page turning lesson in thriller writing, there's no need for deep cranial thinking or fill in the blanks like musings. Scorsese has crafted a movie that, whilst both stylish and moody, is far more intricate than it needed to be.

From the off we saw reams of amateur reviewers dissecting the film and searching for other worldly cinematic meanings. The truth is, is that they don't exist, it is just a great story pinging with psychological twisters. Lehane himself said he felt it was a book he kind of knocked out while in his flow (he undersells himself mind). Scorsese, clearly loving the source to be sure, has crammed too much in for the film to be an across the board winner. Technically accomplished? Without doubt. Depth to the story? You bet. But the reality is that the depth isn't enough to sustain all the genre blending atmospherics that is Marty's want. One is inclined to feel that he so aware that he is treading on well worn genre ground (spot the homages to film noir, old time horror and Hitchcockian grandeur), that he's trying to steer the viewers away from the obviousness on offer. The film is further let down by the second half, where it positively crawls along, something not helped by the fact that the first hour bristles with moody excitement and a promise of clinically executed terror. Anticipation can be a real killer at times...

Yet as is normally the way with a professionally assembled Scorsese picture, there's still so much to enjoy and moments that ensure it will always be a divisive film in the New Yorker's cannon. The cast are mostly great, DiCaprio delivers a stunning performance, one that can only be appreciated once the story has reached the climax. Ruffalo (restrained), Ben Kingsley (shifty) & Max Von Sydow (troubling) all do what is needed and in keeping with the tone of the piece. While the girls - Emily Mortimer, Patricia Clarkson & Williams - have small but crucial parts to play.

Then there's the supporting characters played by some quality character actors. Koteas is joined by Jackie Earle Haley, Ted Levein & John Carroll Lynch. How many of you noticed that we here have a roll call of cinematic serial killers? Edgar Reese, Freddy Krueger, Buffalo Bill and Arthur Lee Allen! (OK, Allen was not proved but "Zodiac" the movie lends us to believe it was him). The music used is suitably heart pounding and Robert Richardson's photography is on the money, especially within the dimly lit Ashecliff walls (the foreboding Medfield State Hospital for location filming). The costumes also have a nice 50s look to them, our first encounter of Teddy & Chuck sees them splendidly adorned in film noir hats and coats. While Thelma Schoonmaker's editing is up to the usual tight standard.

It's always tricky when great directors are involved, so unsurprisingly we witnessed at the start a difference of opinion with the critics as to how good Shutter Island is? What most agreed on was that the film fluctuates in quality and should have been, given the talent behind and in front of the camera, a much better picture. There's also no getting away from the fact that if you have read the book first the impact of the ending is considerably weakened. Personally I feel Scorsese was the wrong director for this particular source, but that's me, and be that as it may, he still manages to come out of it in credit with his fans - though even if he just passed gas some of them would proclaim it as a masterpiece... 7.5/10})

# Collections

# Media

movie_media_mapping = {
  10 => (1..5).to_a,
  11 => (6..10).to_a,
  12 => (11..15).to_a,
  13 => (16..20).to_a,
  4 => (21..25).to_a
}

movie_media_mapping.each do |movie_id, media_ids|
  media_ids.each do |media_id|
    file_path1 = File.join(Rails.root, "public/movies/posters/#{media_id}.jpg")
    file_path2 = File.join(Rails.root, "public/movies/backdrops/#{media_id}.jpg")
    Movie.find(movie_id).posters.attach(io: File.open(file_path1), filename: "#{media_id}.jpg")
    Movie.find(movie_id).backdrops.attach(io: File.open(file_path2), filename: "#{media_id}.jpg")
  end
end

video_ids = {
  10 => ["GekkoBitLvM", "vON5kiGf1TI", "0IVzuZTPwJI", "pY8AnmpD-wE", "KdBxX4S3LIM"],
  11 => ["lhX-IJS82JU", "qdPw9x9h5CY", "mzkVNB3FpSQ", "vmvDCDC9Ylc", "Hz0ToXuAxag", "q_E61O-JZVU"],
  12 => ["3zebJ_NoduE", "5SVNLZXQcP0", "m8nOcQ6834g", "CxrTRZKCbM0", "r2_Xe7Y5ycE"],
  13 => ["HYoTGYT0-I4", "1qL1xZNJfV4", "670mbaibo2U", "Esjc0rPj3K4"],
  4 => ["32RAq6JzY-w", "1w90tQTzJz8", "8oBHRjnQCFE", "hzO1U2hhZ_o", "yyvwReEYUNQ"],
}

video_ids.each do |movie_id, video_ids|
  video_ids.each do |url|
    Video.create!(movie_id: movie_id, url: url)
  end
end

availabilities = %w[stream free add buy rent]
availabilities.each do |availability_type|
  Availability.find_or_create_by(name: availability_type)
end

release_formats = %w[theatrical premier digital physical TV]
release_formats.each do |release_format|
  ReleaseFormat.find_or_create_by(name: release_format)
end

def create_movie_availabilities(movie_id, availabilities)
  availabilities.each do |availability_id|
    MovieAvailability.create!(
      movie_id: movie_id,
      availability_id: availability_id
    )
  end
end

sample_availabilities = {
  1 => [1],
  2 => [1, 2],
  3 => [2, 3],
  4 => [2],
  5 => [3],
  6 => [1, 4],
  7 => [1, 2, 4],
  8 => [1],
  9 => [2],
  10 => [3],
  11 => [4],
  12 => [1, 3],
  13 => [2, 4],
}

sample_availabilities.each do |movie_id, availability_ids|
  create_movie_availabilities(movie_id, availability_ids)
end

sample_release_formats = {
  1 => [1],
  2 => [1, 2],
  3 => [2, 3],
  4 => [2],
  5 => [3],
  6 => [1, 4],
  7 => [1, 2, 4],
  8 => [1],
  9 => [2],
  10 => [3],
  11 => [4],
  12 => [1, 3],
  13 => [2, 4],
}

# Helper method to create movie release formats
def create_movie_release_formats(movie_id, release_formats)
  release_formats.each do |release_format_id|
    MovieReleaseFormat.create!(
      movie_id: movie_id,
      release_format_id: release_format_id
    )
  end
end

sample_release_formats.each do |movie_id, release_formats_ids|
  create_movie_release_formats(movie_id, release_formats_ids)
end

(1..10).each do |user_id|
  (1..13).each do |movie_id|
    Rating.create(user_id: user_id, movie_id: movie_id, score: [10, 20, 30, 40, 50, 60, 70, 80, 90, 100].sample)
  end
end