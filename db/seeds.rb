Category.create(name: 'All')
Category.create(name: 'Mobile development')
Category.create(name: 'Photo')
Category.create(name: 'Web design')


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
            height: 6.4,
            width: 0.9,
            depth: 5.0,
            material: 'Hardcove, glossy paper')

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
            height: 4.4,
            width: 0.5,
            depth: 6.0,
            material: 'Hardcove, glossy paper')