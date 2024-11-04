require 'date'  # Додаємо цей рядок для імпорту класу Date

class Student
  @@students = []  # класова змінна для зберігання унікальних студентів

  attr_accessor :surname, :name, :date_of_birth

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = date_of_birth

    # Перевірка дати народження
    if @date_of_birth > Date.today
      raise ArgumentError, "Дата народження повинна бути в минулому."
    end

    # Перевірка на дублікат
    if @@students.any? { |s| s.name == @name && s.surname == @surname && s.date_of_birth == @date_of_birth }
      raise ArgumentError, "Цей студент вже існує."
    end

    @@students << self  # Додаємо студента до списку
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year

    # Перевіряємо, чи святкував студент свій день народження в поточному році
    age -= 1 if today.month < @date_of_birth.month || (today.month == @date_of_birth.month && today.day < @date_of_birth.day)

    age
  end

  def self.remove_student(student)
    @@students.delete(student)
  end

  def self.get_students_by_age(age)
    @@students.select { |s| s.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |s| s.name == name }
  end

  def self.all_students
    @@students
  end
end

# Приклад використання:
begin
  student1 = Student.new("Іваненко", "Іван", Date.new(2000, 5, 15))
  student2 = Student.new("Петренко", "Петро", Date.new(1998, 8, 22))
  student3 = Student.new("Іваненко", "Іван", Date.new(2000, 5, 15))  # це викличе помилку
rescue ArgumentError => e
  puts e.message
end

puts "Список студентів:"
Student.all_students.each do |student|
  puts "#{student.surname} #{student.name}, Вік: #{student.calculate_age}"
end




