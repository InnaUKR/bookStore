# frozen_string_literal: true

mobile = Category.create(name: 'Mobile development')
biographies = Category.create(name: 'Biographies & Memoirs')
web = Category.create(name: 'Web design')

Book.create(title: 'Real-Life Responsive Web Design',
            price: 32.90,
            description:
                %(Responsive design is a default these days, but we are all still figuring out just the right process
                  and techniques to better craft responsive websites. That’s why Smashing Magazine created a new book —
                  to gather practical techniques and strategies from people who have learned how to get things done
                  right, in actual projects with actual real-world challenges.
                  The Smashing Book 5: Real-Life Responsive Web Design is Smashing Magazine’s brand new book with smart
                  front-end techniques and design patterns derived from real-life responsive projects. Part 1 features
                  7 chapters on responsive workflow, SVG, Flexbox, content strategy, and design patterns — just what
                  you need to master all the tricky facets and hurdles of responsive design.
                  Written by Daniel Mall, Ben Callahan, Eileen Webb, Sara Soueidan, Vitaly Friedman and Zoe M. Gillenwater.
                  Please note that the corresponding Part 2 is also available with even more responsive web design tips
                  and tricks — among others on web fonts, responsive images, email design, performance, debugging and
                  optimizing for offline.),
            date_of_publication: Date.new(2016),
            height: 21,
            width: 16,
            depth: 3,
            material: 'Hardcove, glossy paper',
            category_id: mobile.id)

Book.create(title: 'RESPONSIVE WEB DESIGN',
            price: 18.00,
            description:
                %(Since its groundbreaking release in 2011, Responsive Web Design remains a fundamental resource for
                  anyone working on the web.
                  Learn how to think beyond the desktop, and craft designs that respond to your users’ needs.
                  In the second edition, Ethan Marcotte expands on the design principles behind fluid grids, flexible
                  images, and media queries. Through new examples and updated facts and figures, you’ll learn how to
                  deliver a quality experience, no matter how large or small the display.),
            date_of_publication: Date.new(2018),
            height: 21,
            width: 14.6,
            depth: 2.0,
            material: 'Hardcove, glossy paper',
            category_id: web.id)

Book.create(title: 'Android Phones For Dummies',
            price: 12.04,
            description:
                %(Your smartphone is essentially your lifeline—so it's no wonder you chose a simple-to-use,
                  fun-to-customize, and easy-to-operate Android.
                  Cutting through intimidating jargon and covering all the features you need to know about your Android phone,
                  this down-to-earth guide arms you with the knowledge to set up and configure your device,
                  get up and running with texting and emailing, access the Internet, navigate with GPS,
                  synch with a PC, and so much more.),
            date_of_publication: Date.new(2016),
            height: 24,
            width: 16.6,
            depth: 1.0,
            material: 'Hardcove, glossy paper',
            category_id: mobile.id)

Book.create(title: 'Becoming',
            price: 20.75,
            description:
                %(In a life filled with meaning and accomplishment, Michelle Obama has emerged
                  as one of the most iconic and compelling women of our era.
                  As First Lady of the United States of America—the first African American to serve in that role—she
                  helped create the most welcoming and inclusive White House in history, while also establishing herself
                  as a powerful advocate for women and girls in the U.S. and around the world,
                  dramatically changing the ways that families pursue healthier and more active lives,
                  and standing with her husband as he led America through some of its most harrowing moments.
                  Along the way, she showed us a few dance moves, crushed Carpool Karaoke, and raised two down-to-earth
                  daughters under an unforgiving media glare. ),
            date_of_publication: Date.new(2018),
            height: 20,
            width: 15.0,
            depth: 1.8,
            material: 'Hardcove, glossy paper',
            category_id: biographies.id)


Coupon.create(name: '12345', amount: 0.99)

Delivery.create(method_name: 'ePacket', days: 3)
Delivery.create(method_name: 'Standard Shipping', days: 7)
Delivery.create(method_name: 'Seller\'s Shipping Method', days: 14)

