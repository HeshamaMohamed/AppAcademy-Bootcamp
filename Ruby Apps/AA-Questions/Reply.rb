require_relative 'questions_database'
require_relative 'user'
require_relative 'question'


class Reply
    attr_accessor :id, :question_id, :parent_reply_id, :author_id, :body

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map { |datum| Reply.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @author_id = options['author_id']
        @body = options['body']
    end

    def self.find_by_id(reply_id)
        reply_found = QuestionsDatabase.instance.execute(<<-SQL, reply_id)
        SELECT
            *
        FROM
            replies
        WHERE
            id = ?
        SQL
        return "reply does not exist!" unless reply_found.length > 0
        Reply.new(reply_found.first)
    end

    def self.find_by_user_id(user_id)
        replies_found = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            *
        FROM
            replies
        WHERE
            author_id = ?
        SQL
        return "reply does not exist!" unless replies_found.length > 0
        replies_found.map { |reply| Reply.new(reply) }
    end
    
    def self.find_by_parent_reply_id(parent_id)
        replies_found = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
        SELECT
            *
        FROM
            replies
        WHERE
            parent_reply_id = ?
        SQL
        return "reply does not exist!" unless replies_found.length > 0
        replies_found.map { |reply| Reply.new(reply) }
    end

    def self.find_by_question_id(question_id)
        replies_found = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            replies
        WHERE
            question_id = ?
        SQL
        return "reply does not exist!" unless replies_found.length > 0
        replies_found.map { |reply| Reply.new(reply) }
    end

    def author
        User.find_by_id(self.author_id)
    end

    def question
        Question.find_by_id(self.question_id)
    end

    def parent_reply
        Reply.find_by_id(self.parent_reply_id)
    end

    def child_replies
        Reply.find_by_parent_reply_id(self.id)
    end

end