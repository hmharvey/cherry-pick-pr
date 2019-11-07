#!/usr/bin/env ruby

require "json"
require "open-uri"

if ENV["GITHUB_EVENT_NAME"] == "pull_request"
  payload = JSON.parse(File.read(ENV["GITHUB_EVENT_PATH"]))
  commits = JSON.parse(open(payload["pull_request"]["commits_url"]).read)
  commits.each do |commit|
    `git cherry-pick #{commit["sha"]}`
    `git config user.email "#{commit["commit"]["author"]["email"]}"
    `git config user.name "#{commit["commit"]["author"]["name"]}"
    end
end
