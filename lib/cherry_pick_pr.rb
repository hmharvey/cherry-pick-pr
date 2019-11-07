#!/usr/bin/env ruby

require "json"
require "open-uri"
require "securerandom"

if ENV["GITHUB_EVENT_NAME"] == "pull_request"
  branch_name = ENV["INPUT_LABELS"]
  `git checkout -b #{branch_name}` 
  payload = JSON.parse(File.read(ENV["GITHUB_EVENT_PATH"]))
  commits = JSON.parse(open(payload["pull_request"]["commits_url"]).read)
  commits.each do |commit|
    `git config user.email "#{commit["commit"]["author"]["email"]}"`
    `git config user.name "#{commit["commit"]["author"]["name"]}"`
    `git cherry-pick #{commit["sha"]}`
    end
  `git push`
  `echo "::set-output name=branch_name::#{branch_name}"`
end
