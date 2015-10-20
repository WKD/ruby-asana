### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # A _project_ represents a prioritized list of tasks in Asana. It exists in a
    # single workspace or organization and is accessible to a subset of users in
    # that workspace or organization, depending on its permissions.
    #
    # Projects in organizations are shared with a single team. You cannot currently
    # change the team of a project via the API. Non-organization workspaces do not
    # have teams and so you should not specify the team of project in a
    # regular workspace.
    class Project < Resource

      include EventSubscription


      attr_reader :name

      attr_reader :id

      attr_reader :owner

      attr_reader :current_status

      attr_reader :due_date

      attr_reader :created_at

      attr_reader :modified_at

      attr_reader :archived

      attr_reader :public

      attr_reader :members

      attr_reader :followers

      attr_reader :color

      attr_reader :notes

      attr_reader :workspace

      attr_reader :team

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'projects'
        end

        # Creates a new project in a workspace or team.
        #
        # Every project is required to be created in a specific workspace or
        # organization, and this cannot be changed once set. Note that you can use
        # the `workspace` parameter regardless of whether or not it is an
        # organization.
        #
        # If the workspace for your project _is_ an organization, you must also
        # supply a `team` to share the project with.
        #
        # Returns the full record of the newly created project.
        #
        # workspace - [Id] The workspace or organization to create the project in.
        # team - [Id] If creating in an organization, the specific team to create the
        # project in.
        #
        # options - [Hash] the request I/O options.
        # data - [Hash] the attributes to post.
        def create(client, workspace: required("workspace"), team: nil, options: {}, **data)
          with_params = data.merge(workspace: workspace, team: team).reject { |_,v| v.nil? || Array(v).empty? }
          self.new(parse(client.post("/projects", body: with_params, options: options)).first, client: client)
        end

        # If the workspace for your project _is_ an organization, you must also
        # supply a `team` to share the project with.
        #
        # Returns the full record of the newly created project.
        #
        # workspace - [Id] The workspace or organization to create the project in.
        # options - [Hash] the request I/O options.
        # data - [Hash] the attributes to post.
        def create_in_workspace(client, workspace: required("workspace"), options: {}, **data)

          self.new(parse(client.post("/workspaces/#{workspace}/projects", body: data, options: options)).first, client: client)
        end

        # Creates a project shared with the given team.
        #
        # Returns the full record of the newly created project.
        #
        # team - [Id] The team to create the project in.
        # options - [Hash] the request I/O options.
        # data - [Hash] the attributes to post.
        def create_in_team(client, team: required("team"), options: {}, **data)

          self.new(parse(client.post("/teams/#{team}/projects", body: data, options: options)).first, client: client)
        end

        # Returns the complete project record for a single project.
        #
        # id - [Id] The project to get.
        # options - [Hash] the request I/O options.
        def find_by_id(client, id, options: {})

          self.new(parse(client.get("/projects/#{id}", options: options)).first, client: client)
        end

        # Returns the compact project records for some filtered set of projects.
        # Use one or more of the parameters provided to filter the projects returned.
        #
        # workspace - [Id] The workspace or organization to filter projects on.
        # team - [Id] The team to filter projects on.
        # archived - [Boolean] Only return projects whose `archived` field takes on the value of
        # this parameter.
        #
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_all(client, workspace: nil, team: nil, archived: nil, per_page: 20, options: {})
          params = { workspace: workspace, team: team, archived: archived, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/projects", params: params, options: options)), type: self, client: client)
        end

        # Returns the compact project records for all projects in the workspace.
        #
        # workspace - [Id] The workspace or organization to find projects in.
        # archived - [Boolean] Only return projects whose `archived` field takes on the value of
        # this parameter.
        #
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_by_workspace(client, workspace: required("workspace"), archived: nil, per_page: 20, options: {})
          params = { archived: archived, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/workspaces/#{workspace}/projects", params: params, options: options)), type: self, client: client)
        end

        # Returns the compact project records for all projects in the team.
        #
        # team - [Id] The team to find projects in.
        # archived - [Boolean] Only return projects whose `archived` field takes on the value of
        # this parameter.
        #
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_by_team(client, team: required("team"), archived: nil, per_page: 20, options: {})
          params = { archived: archived, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/teams/#{team}/projects", params: params, options: options)), type: self, client: client)
        end
      end

      # A specific, existing project can be updated by making a PUT request on the
      # URL for that project. Only the fields provided in the `data` block will be
      # updated; any unspecified fields will remain unchanged.
      #
      # When using this method, it is best to specify only those fields you wish
      # to change, or else you may overwrite changes made by another user since
      # you last retrieved the task.
      #
      # Returns the complete updated project record.
      #
      # options - [Hash] the request I/O options.
      # data - [Hash] the attributes to post.
      def update(options: {}, **data)

        refresh_with(parse(client.put("/projects/#{id}", body: data, options: options)).first)
      end

      # A specific, existing project can be deleted by making a DELETE request
      # on the URL for that project.
      #
      # Returns an empty data record.
      def delete()

        client.delete("/projects/#{id}") && true
      end

      # Returns compact records for all sections in the specified project.
      #
      # per_page - [Integer] the number of records to fetch per page.
      # options - [Hash] the request I/O options.
      def sections(per_page: 20, options: {})
        params = { limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
        Collection.new(parse(client.get("/projects/#{id}/sections", params: params, options: options)), type: Resource, client: client)
      end

      # Returns the compact task records for all tasks within the given project,
      # ordered by their priority within the project. Tasks can exist in more than one project at a time.
      #
      # per_page - [Integer] the number of records to fetch per page.
      # options - [Hash] the request I/O options.
      def tasks(per_page: 20, options: {})
        params = { limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
        Collection.new(parse(client.get("/projects/#{id}/tasks", params: params, options: options)), type: Task, client: client)
      end

      # Adds the specified list of users as followers to the project. Followers are a subset of members, therefore if
      # the users are not already members of the project they will also become members as a result of this operation.
      # Returns the updated project record.
      #
      # followers - [Array] An array of followers to add to the project.
      # options - [Hash] the request I/O options.
      # data - [Hash] the attributes to post.
      def add_followers(followers: required("followers"), options: {}, **data)
        with_params = data.merge(followers: followers).reject { |_,v| v.nil? || Array(v).empty? }
        refresh_with(parse(client.post("/projects/#{id}/addFollowers", body: with_params, options: options)).first)
      end

      # Removes the specified list of users from following the project, this will not affect project membership status.
      # Returns the updated project record.
      #
      # followers - [Array] An array of followers to remove from the project.
      # options - [Hash] the request I/O options.
      # data - [Hash] the attributes to post.
      def remove_followers(followers: required("followers"), options: {}, **data)
        with_params = data.merge(followers: followers).reject { |_,v| v.nil? || Array(v).empty? }
        refresh_with(parse(client.post("/projects/#{id}/removeFollowers", body: with_params, options: options)).first)
      end

      # Adds the specified list of users as members of the project. Returns the updated project record.
      #
      # members - [Array] An array of members to add to the project.
      # options - [Hash] the request I/O options.
      # data - [Hash] the attributes to post.
      def add_members(members: required("members"), options: {}, **data)
        with_params = data.merge(members: members).reject { |_,v| v.nil? || Array(v).empty? }
        refresh_with(parse(client.post("/projects/#{id}/addMembers", body: with_params, options: options)).first)
      end

      # Removes the specified list of members from the project. Returns the updated project record.
      #
      # members - [Array] An array of members to remove from the project.
      # options - [Hash] the request I/O options.
      # data - [Hash] the attributes to post.
      def remove_members(members: required("members"), options: {}, **data)
        with_params = data.merge(members: members).reject { |_,v| v.nil? || Array(v).empty? }
        refresh_with(parse(client.post("/projects/#{id}/removeMembers", body: with_params, options: options)).first)
      end

    end
  end
end