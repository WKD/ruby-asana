### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.
require_relative 'resource'

module Asana
  module Resources
    # A _user_ object represents an account in Asana that can be given access to
    # various workspaces, projects, and tasks.
    #
    # Like other objects in the system, users are referred to by numerical IDs.
    # However, the special string identifier `me` can be used anywhere
    # a user ID is accepted, to refer to the current authenticated user.
    class User < Resource

      attr_reader :id

      attr_reader :email

      attr_reader :photo

      attr_reader :workspaces

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'users'
        end

        # Returns the full user record for the currently authenticated user.
        def me(client:)

          new(body(client.get("/users/me")), client: client)
        end

        # Returns the full user record for a single user.
        #
        # id - [Id] Globally unique identifier for the user.
        def find_by_id(id, client:)

          new(body(client.get("/users/#{id}")), client: client)
        end

        # Returns the user records for all users in all workspaces and organizations
        # accessible to the authenticated user.
        #
        # workspace - [Id] The workspace in which to get users.
        def find_by_workspace(workspace:, client:)

          Collection.new(body(client.get("/workspaces/#{workspace}/users")), client: client)
        end

        # Returns the user records for all users in the specified workspace or
        # organization.
        #
        # workspace - [Id] The workspace or organization to filter users on.
        def find_all(workspace: nil, client:)
          params = { workspace: workspace }.reject { |_,v| v.nil? }
          Collection.new(body(client.get("/users", params: params)), client: client)
        end
      end

    end
  end
end

