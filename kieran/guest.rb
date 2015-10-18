class Guest

  @@list_of_first_names = ["Barney", "Greg", "Delmer", "Kelley", "Van", "Santiago", "Clark", "Buddy", "Curt", "Shelton", "Richie", "Tyrell", "Francis", "Quincy", "Ross", "Wiley", "Ray", "Gino", "Isaias", "Roman", "Tajuana", "Veronica", "Kacy", "Mallie", "Yu", "Roma", "Lela", "Karmen", "Bev", "Halley", "Lashandra", "Kalyn", "Nedra", "Arlena", "Eartha", "Nadine", "Mariko", "Lashell", "Lorretta", "Florrie"]
  @@list_of_last_names = ["Mcconnell", "Elliott", "King", "Brady", "Murray", "Hahn", "Bauer", "Hodge", "Shepherd", "Perry", "Weiss", "Nielsen", "Bender", "Bradford", "Fleming", "Herring", "Little", "Mosley", "Diaz", "Luna", "Matthews", "Payne", "Berry", "Sampson", "Garner", "Knox", "Green", "Lewis", "Chung", "Pena", "Chaney", "Hess", "Colon", "Lynch", "Vaughan", "Hartman", "Wyatt", "Huffman", "Martinez", "Prince"]

  def self.list_of_last_names
    @@list_of_last_names
  end

  attr_reader :first_name, :last_name
  attr_accessor :in_room

  def initialize(options={})
    @first_name = @@list_of_first_names.sample
    @last_name = options.fetch(:last_name, @@list_of_last_names.sample)
    @in_room = nil
  end

  def name
    "#{first_name} #{last_name}"
  end

  def get_room
    in_room
  end

  def check_in_to(room_number)
    self.in_room = room_number
  end

end