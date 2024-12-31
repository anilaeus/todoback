module Api
  module V1
    class TodosController< ApplicationController
      before_action :set_todo, only: %i[ show update updated_completed destroy ]

      # GET /todos
      def index
        @todos = Todo.all.order(created_at: :desc)
        # @completed_todos = Todo.all.where(completed: true).order(created_at: :desc)
        # @uncompleted_todos = Todo.all.where(completed: false).order(created_at: :desc)
        # render json: {
        #   completed_todos: @completed_todos.as_json(except: [:created_at, :updated_at]),
        #   uncompleted_todos: @uncompleted_todos.as_json(except: [:created_at, :updated_at])
        # }
        render json: @todos.as_json(except: [:created_at, :updated_at])
      end

      # GET /todos/1
      def show
        render json: @todo
      end

      # POST /todos
      def create
        @todo = Todo.new(todo_params)

        if @todo.save
          render json: @todo, status: :created, location: @todo
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /todos/1
      def update
        if @todo.update(todo_params)
          render json: @todo
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      def updated_completed
        if(@todo.update(completed: params[:completed]))
          render json: @todo
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      # DELETE /todos/1
      def destroy
        @todo.destroy!
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_todo
          @todo = Todo.find(params.expect(:id))
        end

        # Only allow a list of trusted parameters through.
        def todo_params
          params.expect(todo: [ :todo_name, :completed ])
        end
    end
  end
end
