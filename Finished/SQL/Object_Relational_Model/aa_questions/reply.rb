require_relative 'model_base'

class Reply < ModelBase
  attr_accessor :id, :question_id, :reply_id, :user_id, :body

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT *
        FROM replies
       WHERE user_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT *
        FROM replies
       WHERE question_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @reply_id = options['reply_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    return nil if reply_id.nil?

    Reply.find_by_id(reply_id)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
        FROM replies
       WHERE reply_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| Reply.new(datum) }
  end
end
