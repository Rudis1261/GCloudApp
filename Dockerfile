FROM ruby:2.4.3

ADD . /usr/local/src/
WORKDIR /usr/local/src/

RUN gem install bundler
RUN bundle install --full-index

# After the initial bundle, change the permissions of the gems folder so that all
# users can update the gems. This allows for the docker instance to be run and updated
# as another user (such as the user executing the docker run on the host system)
# so that artifacts from mounted volumes will be owned by the user and not root.
RUN chmod -R o+rwx /usr/local/bundle

EXPOSE 8080
CMD bundle exec ruby app.rb -o 0.0.0.0 -p 8080