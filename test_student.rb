require 'minitest/autorun'
require 'date'
require_relative 'ruby'  # Залиште правильний шлях до вашого файлу з класом Student

class TestStudent < Minitest::Test
  def setup
    Student.class_variable_set(:@@students, []) # Очищення списку студентів перед кожним тестом
    @student1 = Student.new("Іваненко", "Іван", Date.new(2000, 5, 15))
    @student2 = Student.new("Петренко", "Петро", Date.new(1998, 8, 22))
  end

  def test_calculate_age
    assert_equal 24, @student1.calculate_age  # (2024 - 2000)
  end

  def test_duplicate_student
    assert_raises(ArgumentError) do
      Student.new("Іваненко", "Іван", Date.new(2000, 5, 15))  # Повторний студент
    end
  end

  def test_future_date_of_birth
    assert_raises(ArgumentError) do
      Student.new("Сидоренко", "Сидір", Date.new(2025, 1, 1))  # Дата в майбутньому
    end
  end

  def test_get_students_by_age
    assert_equal [@student1], Student.get_students_by_age(24)
  end

  def test_get_students_by_name
    assert_equal [@student1], Student.get_students_by_name("Іван")
  end

  def test_remove_student
    Student.remove_student(@student1)
    assert_equal [@student2], Student.all_students  # Очікуємо, що залишився тільки другий студент
  end

  def teardown
    # Очищення списку студентів для тестування
    Student.class_variable_set(:@@students, [])
  end
end

