FROM ruby:2.6.5

COPY lib/cherry_pick_pr.rb /cherry_pick_pr.rb
ENTRYPOINT ["/cherry_pick_pr.rb"]
