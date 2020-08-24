class Response < ApplicationRecord

    belongs_to :answer_choice,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class_name: 'AnswerChoice'
    
    belongs_to :respondent,
        primary_key: :id,
        foreign_key: :respondent_id,
        class_name: 'User'

    has_one :question,
        through: :answer_choice,
        source: :question

    validate :respondent_not_author, unless: -> { answer_choice.nil? }

    validate :not_duplicate_response, unless: -> { answer_choice.nil? }

    def sibling_responses
        self.question.responses.where.not('responses.id = ?',self.id)
    end

    def respondent_already_answered?
        sibling_responses.exists?(respondent_id: self.respondent_id)
    end

    def not_duplicate_response
        errors[:respondent_id] << 'already answered this question' if respondent_already_answered?
    end

    def respondent_not_author
        poll_author_id = self.answer_choice.question.poll.author_id

        if poll_author_id == self.respondent_id
            errors[:respondent_id] << 'cannot answer own poll'
        end
    end
    
end