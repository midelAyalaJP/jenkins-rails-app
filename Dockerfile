# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/CHANGELOG.md for
# a list of version numbers.
#FROM phusion/passenger-full
# Or, instead of the 'full' variant, use one of these:
#FROM phusion/passenger-ruby27:<VERSION>
#FROM phusion/passenger-ruby30:<VERSION>
FROM phusion/passenger-ruby31:2.3.1
#FROM phusion/passenger-ruby32:<VERSION>
#FROM phusion/passenger-jruby93:<VERSION>
#FROM phusion/passenger-nodejs:<VERSION>
#FROM phusion/passenger-customizable

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
#CMD ["/sbin/my_init"]

# If you're using the 'customizable' variant, you need to explicitly opt-in
# for features.
#
# N.B. these images are based on https://github.com/phusion/baseimage-docker,
# so anything it provides is also automatically on board in the images below
# (e.g. older versions of Ruby, Node, Python).
#
# Uncomment the features you want:
#
#   Ruby support
#RUN /pd_build/ruby-2.7.*.sh
#RUN /pd_build/ruby-3.0.*.sh
#RUN /pd_build/ruby-3.1.*.sh
#RUN /pd_build/ruby-3.2.*.sh
#RUN /pd_build/jruby-9.3.*.sh
#   Python support.
#RUN /pd_build/python.sh
#   Node.js and Meteor standalone support.
#   (not needed if you already have the above Ruby support)
#RUN /pd_build/nodejs.sh

#RUN bash -lc 'echo $(ruby -v)'
# RUN bash -lc 'rvm --default use ruby-3.1.2'
# ...put your own build instructions here...
# RUN rm -f /etc/service/nginx/down
# RUN rm /etc/nginx/sites-enabled/default
# ADD webapp.conf /etc/nginx/sites-enabled/default.conf
RUN mkdir /home/app/webapp
# ADD secret_key.conf /etc/nginx/main.d/secret_key.conf
# ADD gzip_max.conf /etc/nginx/conf.d/gzip_max.conf

COPY --chown=app:app . /home/app/webapp
WORKDIR /home/app/webapp
RUN rvm-exec 3.1.2 bundle install

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*