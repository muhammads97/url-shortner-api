# Intial Setup

    docker-compose build
    docker-compose up mariadb
    # Once mariadb says it's ready for connections, you can use ctrl + c to stop it
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc

# Encoding Algorithm

The encoding algorithm used in this project is a basic counting algorithm, where the CHARACTERS array is the symbols space, with 62 sysmbols. This makes a numbering system with 62 as the base.

The algorithm basically works by converting the id from the decimal space to the new numbering system with base 62.

unlike the traditional numbering systems, the leading zeros are considered valid to utilize every symbol in the space and get the shortest possible code for the next url.

# Decoding Algorithm

The decoding happens in a similar fashion, where the short_codes are converted back to the decimal space to represent the id of the url.

# Alternative Approach

The Encoding technique can remain the same, but we can eliminate the additional computational complexity of the decoding algorithm by storing the short_code along with the url and adding a database index to it.

The two approaches are valid, but it's a trade off between storage and computation.
