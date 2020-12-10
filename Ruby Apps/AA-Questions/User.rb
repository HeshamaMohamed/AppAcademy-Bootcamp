
require_relative 'questions_database'
require_relative 'question'
require_relative 'question_like'
require_relative 'reply'

class User
    attr_accessor :id, :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| User.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def self.find_by_id(id)
        id_found = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            users
        WHERE
            id = ?
        SQL
        return "User does not exist!" unless id_found.length > 0
        User.new(id_found.first)
    end


    def self.find_by_name(name)
        name = name.split(" ")
        fname, lname = name[0], name[1]
        attrs = { fname: fname, lname: lname }
        name_found = QuestionsDatabase.instance.execute(<<-SQL, attrs)
        SELECT
            *
        FROM
            users
        WHERE
            fname = :fname AND lname = :lname
        SQL
        return "User does not exist!" unless name_found.length > 0
        User.new(name_found.first)
    end

    def authored_questions
        Question.find_by_author_id(self.id)
    end

    def authored_replies
        Reply.find_by_user_id(self.id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(self.id)
    end
    def attrs
        { fname: fname, lname: lname }
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(self.id)
    end

end



