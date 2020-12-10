require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionLike
    attr_accessor :id, :user_id, :question_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map { |datum| QuestionLike.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

    def self.find_by_id(id)
        like_found = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_likes
        WHERE
            id = ?
        SQL
        return "like does not exist!" unless like_found.length > 0
        QuestionLike.new(like_found.first)
    end

    def self.likers_for_question_id(question_id)
        likers_found = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            users
        JOIN
            question_likes
        ON 
            question_likes.user_id = users.id
        WHERE
            question_id = ?
        SQL
        return "likers does not exist!" unless likers_found.length > 0
        likers_found.map { |liker| User.new(liker) }
    end
  
    
    def self.num_likes_for_question_id(question_id)
        num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            COALESCE(COUNT(id), 0)
        FROM
            question_likes
        WHERE
            question_id = ?
        SQL
    end

    def self.num_likes_for_user_id(user_id)
        num_likes = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            COALESCE(COUNT(id), 0)
        FROM
            question_likes
        WHERE
            user_id = ?
        SQL
    end

    def self.liked_questions_for_user_id(user_id)
        questions_found = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            questions
        JOIN
            question_likes
        ON
            question_likes.question_id = questions.id
        WHERE
            question_likes.user_id = ?
        SQL
        return "likers does not exist!" unless questions_found.length > 0
        questions_found.map { |question| Question.new(question) }
    end
end