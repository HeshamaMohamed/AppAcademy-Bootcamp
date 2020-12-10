require_relative 'questions_database'
require_relative 'user'
require_relative 'question'



class QuestionFollow
    attr_accessor :id, :user_id, :question_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map { |datum| QuestionFollow.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

    def self.find_by_id(id)
        follow_found = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_follows
        WHERE
            id = ?
        SQL
        return "follow does not exist!" unless follow_found.length > 0
        QuestionFollow.new(follow_found.first)
    end

    def self.followers_for_question_id(question_id)
        followers_found = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            users
        JOIN
            question_follows
        ON 
            question_follows.user_id = users.id
        WHERE
            question_id = ?
        SQL
        return "follow does not exist!" unless followers_found.length > 0
        followers_found.map { |follower| User.new(follower) }
    end

    def self.followed_questions_for_user_id(user_id)
        questions_found = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            *
        FROM
            questions
        JOIN
            question_follows
        ON
            question_follows.question_id = questions.id
        WHERE
            question_follows.user_id = ?
        SQL
        # return "questions do not exist!" unless questions_found.length > 0
        # questions_found.map { |question| Question.new(question)  }
    end

    def self.most_followed_questions(n)
        questions_found = QuestionsDatabase.instance.execute(<<-SQL)
        SELECT
            *
        FROM
            questions
        JOIN
            question_follows
        ON 
            question_follows.question_id = questions.id
        GROUP BY 
            question_id
        ORDER BY 
            COUNT(question_id) DESC
        SQL
    end

end