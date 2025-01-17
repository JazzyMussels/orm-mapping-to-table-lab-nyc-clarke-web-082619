class Student
  attr_reader :id
  attr_accessor :name, :grade 


  def initialize(name, grade, id=nil)
    @name = name 
    @grade = grade
    @id = id 
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql4 = "DROP TABLE IF EXISTS students" 
    DB[:conn].execute(sql4)
  end

 def save
    sql5 = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL
 
    DB[:conn].execute(sql5, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
  
end
