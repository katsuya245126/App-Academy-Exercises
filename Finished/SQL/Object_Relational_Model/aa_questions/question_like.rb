require_relative 'model_base'

class QuestionLike < ModelBase
  attr_accessor :id, :question_id, :user_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
        FROM question_likes
       WHERE id = ?
    SQL

    return nil if data.empty?

    QuestionLike.new(data.first)
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT u.*
        FROM question_likes AS ql
             JOIN users AS u
             ON ql.user_id = u.id
       WHERE ql.question_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT COUNT(*) AS num_likes
        FROM question_likes AS ql
       WHERE ql.question_id = ?
    SQL

    data.first['num_likes']
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT q.*
        FROM question_likes AS ql
             JOIN questions AS q
             ON ql.question_id = q.id
       WHERE ql.user_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT q.*,
             COUNT(*) AS likes
        FROM question_likes AS ql
             JOIN questions AS q
             ON ql.question_id = q.id
       GROUP BY ql.question_id
       ORDER BY likes DESC
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
