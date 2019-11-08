#!/usr/bin/env ruby

require "json"
require "open-uri"
require "securerandom"

if ENV["GITHUB_EVENT_NAME"] == "pull_request"
  payload = JSON.parse(File.read(ENV["GITHUB_EVENT_PATH"]))

  if payload["pull_request"]["head"]["repo"]["fork"]
#     `git remote add forked-repo "#{payload["pull_request"]["head"]["repo"]["clone_url"]}"`
#     `git fetch forked-repo`
#     puts "forked-repo"
#     puts "#{payload["pull_request"]["head"]["repo"]["clone_url"]}"
  end
  
  branch_name = "cherry-pick-#{SecureRandom.hex(10)}"
  puts `git status -b --porcelain`
  `git checkout -b "#{branch_name}"` 

#   commits = JSON.parse(open(payload["pull_request"]["commits_url"]).read)
#   commits.each do |commit|
#     `git config user.email "#{commit["commit"]["author"]["email"]}"`
#     `git config user.name "#{commit["commit"]["author"]["name"]}"`
#     `git cherry-pick "#{commit["sha"]}"`
#     end

  puts "before git push"
#   `git push origin "#{branch_name}"`

  `git remote add origin git@github.com:hmharvey/fictional-barnacle.git`
  # remote_repo="https://#{ENV["GITHUB_ACTOR"]}:#{ENV["GITHUB_TOKEN"]}@github.com/#{ENV["GITHUB_REPOSITORY"]}.git"
#   `git push "#{remote_repo}" "#{branch_name}"` 
  `git push -u origin "#{branch_name}"`
  puts "after git push"

  # delete remote if fork
  puts `echo ::set-output name=branch_name::"#{branch_name}"`
end
