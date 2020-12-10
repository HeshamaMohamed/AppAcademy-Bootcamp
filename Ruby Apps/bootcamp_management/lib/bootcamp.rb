class Bootcamp
  
    def initialize(name, slogan, student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity
        @students = []
        @teachers = []
        @grades = Hash.new { |hash,k| hash[k] = []}
    end

    def name
        @name
    end
    def name=(string)
        @name=string
    end

    def slogan
        @slogan
    end
    def slogan=(string)
        @slogan = string
    end

    def student_capacity
        @student_capacity
    end
    def student_capacity=(number)
        @student_capacity = number
    end

    def teachers
        @teachers
    end
    def hire(string)
        @teachers << string
    end

    def students
        @students
    end
    def enroll(string)
        if @students.count < student_capacity
            @students << string
            true
        else
            false
        end
    end
    def enrolled?(string)
        @students.include?(string)
    end

    def student_to_teacher_ratio
        @students.count / @teachers.count
    end

    def add_grade(string, number)
        if @students.include?(string)
            @grades[string] << number
            true
        else
            false
        end
    end

    def num_grades(string)
        @grades[string].count
    end
    def average_grade(string)
        return @grades[string].sum / @grades[string].count if @students.include?(string) && @grades[string].count > 0
        return nil
    end



end
