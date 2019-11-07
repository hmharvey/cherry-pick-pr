#!/usr/bin/env ruby

require "json"
require "open-uri"

if ENV["GITHUB_EVENT_NAME"] == "pull_request"
  payload = JSON.parse(File.read(ENV["GITHUB_EVENT_PATH"]))
  commits = JSON.parse(open(payload["pull_request"]["commits_url"]))
  commits.each { |commit| puts commit["sha"] }
end
