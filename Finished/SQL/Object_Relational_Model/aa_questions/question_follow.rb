require_relative 'model_base'

class QuestionFollow < ModelBase
  attr_accessor :id, :question_id, :user_id

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT u.*
        FROM question_follows AS qf
             JOIN users AS u
             ON qf.user_id = u.id
       WHERE qf.question_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT q.*
        FROM question_follows AS qf
             JOIN questions AS q
             ON qf.question_id = q.id
       WHERE qf.user_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT q.*,
             COUNT(*) AS total_followers
        FROM question_follows AS qf
             JOIN questions AS q
             ON qf.question_id = q.id
       GROUP BY qf.question_id
       ORDER BY total_followers DESC
      LIMIT ?
    SQL

    return nil if data.empty?

    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end
