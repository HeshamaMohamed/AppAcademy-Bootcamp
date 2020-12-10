require_relative 'questions_database'
require_relative 'user'
require_relative 'reply'
require_relative 'question_like'

class Question
    attr_accessor :id, :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Question.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def self.find_by_id(id)
        id_found = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            questions
        WHERE
            id = ?
        SQL
        return "question does not exist!" unless id_found.length > 0
        Question.new(id_found.first)
    end

    def self.find_by_author_id(author_id)
        questions_found = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT
            *
        FROM
            questions
        WHERE
            author_id = ?
        SQL
        return "question does not exist!" unless questions_found.length > 0
        questions_found.map { |question| Question.new(question) }
    end
  
    def author
        User.find_by_id(self.author_id)
    end

    def replies
        Reply.find_by_user_id(self.id)
    end

    def followers
        QuestionFollow.followers_for_question_id(self.id)
    end

    def most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def likers
        QuestionLike.likers_for_question_id(self.id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(self.id)
    end

    
end