Todo.destroy_all

(1..50).each_with_index do |_,index|
    Todo.create(todo_name: "test #{index + 1}")
end