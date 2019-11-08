#!/usr/bin/env ruby

require "json"
require "open-uri"
require "securerandom"

if ENV["GITHUB_EVENT_NAME"] == "pull_request"
  payload = JSON.parse(File.read(ENV["GITHUB_EVENT_PATH"]))
  commits = JSON.parse(open(payload["pull_request"]["commits_url"]).read)

  if payload["repository"]["fork"]
    `git remote add forked-branch "#{payload["repository"]["clone_url"]}"`
    `git fetch forked-branch`
    puts "forked-branch"
    puts "#{payload["repository"]["clone_url"]}"
  end
  
  branch_name = "cherry-pick-#{SecureRandom.hex(10)}"
  `git checkout -b "#{branch_name}"` 

  commits.each do |commit|
    `git config user.email "#{commit["commit"]["author"]["email"]}"`
    `git config user.name "#{commit["commit"]["author"]["name"]}"`
    `git cherry-pick "#{commit["sha"]}"`
    end
  `git push --set-upstream origin "#{branch_name}"`
  `echo ::set-output name=branch_name::"#{branch_name}"`
end
