
class Poll
    validates :title, :author_id, presence: true

    belongs_to :author,
        primary_key: :id,
        foreign_key: :author_id,
        class: 'User'

    has_many :questions,
        primary_key: :id,
        foreign_key: :poll_id,
        class: 'Question'
end 