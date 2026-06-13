extends Node

var correct:bool

var questions = [
  {
	"question": "What is the purpose of persuasive writing?",
	"answers": [
	  "To entertain the reader",
	  "To inform the reader",
	  "To convince the reader of a viewpoint",
	  "To describe a setting"
	],
	"correct": 2
  },
  {
	"question": "Which sentence contains an adjective?",
	"answers": [
	  "She ran quickly.",
	  "The bright sun shone overhead.",
	  "They arrived yesterday.",
	  "Birds fly south."
	],
	"correct": 1
  },
  {
	"question": "What is the meaning of 'infer' while reading?",
	"answers": [
	  "To copy information",
	  "To guess using clues from the text",
	  "To skip difficult words",
	  "To rewrite a sentence"
	],
	"correct": 1
  },
  {
	"question": "Which punctuation mark is used to show possession?",
	"answers": [
	  "Comma",
	  "Question mark",
	  "Apostrophe",
	  "Colon"
	],
	"correct": 2
  },
  {
	"question": "What is the purpose of a bibliography?",
	"answers": [
	  "To summarise the story",
	  "To list the sources used",
	  "To explain characters",
	  "To add dialogue"
	],
	"correct": 1
  },
  {
	"question": "Which sentence is a fact?",
	"answers": [
	  "Pizza is the best food.",
	  "Summer is boring.",
	  "Water boils at 100°C.",
	  "Cats are nicer than dogs."
	],
	"correct": 2
  },
  {
	"question": "What is an antonym for 'expand'?",
	"answers": [
	  "Increase",
	  "Stretch",
	  "Reduce",
	  "Develop"
	],
	"correct": 2
  },
  {
	"question": "Which sentence contains alliteration?",
	"answers": [
	  "The river flowed gently.",
	  "Peter Piper picked peppers.",
	  "The dog barked loudly.",
	  "She walked carefully."
	],
	"correct": 1
  },
  {
	"question": "What is the purpose of an introduction?",
	"answers": [
	  "To summarise the text",
	  "To introduce the main topic",
	  "To provide references",
	  "To end the discussion"
	],
	"correct": 1
  },
  {
	"question": "Which word is a verb?",
	"answers": [
	  "Beautiful",
	  "Quickly",
	  "Run",
	  "Blue"
	],
	"correct": 2
  },
  {
	"question": "What does skimming a text involve?",
	"answers": [
	  "Reading every word carefully",
	  "Reading quickly for main ideas",
	  "Ignoring headings",
	  "Memorising details"
	],
	"correct": 1
  },
  {
	"question": "Which sentence uses capital letters correctly?",
	"answers": [
	  "my friend lives in Auckland.",
	  "My friend lives in Auckland.",
	  "My Friend lives in auckland.",
	  "my Friend Lives in Auckland."
	],
	"correct": 1
  },
  {
	"question": "What is a thesis statement?",
	"answers": [
	  "A joke in the conclusion",
	  "The main argument of an essay",
	  "A random quote",
	  "A bibliography entry"
	],
	"correct": 1
  },
  {
	"question": "Which is an example of emotive language?",
	"answers": [
	  "The car is red.",
	  "The tragic accident shocked the town.",
	  "Water is transparent.",
	  "The report contains data."
	],
	"correct": 1
  },
  {
	"question": "What is the purpose of proofreading?",
	"answers": [
	  "To publish immediately",
	  "To check for errors",
	  "To add pictures",
	  "To shorten paragraphs"
	],
	"correct": 1
  },
  {
	"question": "Which sentence contains a simile?",
	"answers": [
	  "The classroom was a zoo.",
	  "He ran like the wind.",
	  "The stars danced above.",
	  "The rain fell heavily."
	],
	"correct": 1
  },
  {
	"question": "What does the word 'analyse' mean?",
	"answers": [
	  "To ignore details",
	  "To examine carefully",
	  "To memorise",
	  "To simplify completely"
	],
	"correct": 1
  },
  {
	"question": "Which sentence is written in first person?",
	"answers": [
	  "She went to the park.",
	  "They completed the project.",
	  "I enjoy reading novels.",
	  "The students studied hard."
	],
	"correct": 2
  },
  {
	"question": "What is a paragraph mainly about?",
	"answers": [
	  "Several unrelated ideas",
	  "One main idea",
	  "Only dialogue",
	  "A title"
	],
	"correct": 1
  },
  {
	"question": "Which sentence contains personification?",
	"answers": [
	  "The leaves danced in the wind.",
	  "She sings beautifully.",
	  "The car is fast.",
	  "The hill is steep."
	],
	"correct": 0
  },
  {
	"question": "What is the purpose of a recount?",
	"answers": [
	  "To argue a point",
	  "To retell events",
	  "To explain a process",
	  "To advertise a product"
	],
	"correct": 1
  },
  {
	"question": "Which word is an adverb?",
	"answers": [
	  "Happiness",
	  "Quickly",
	  "Mountain",
	  "Blue"
	],
	"correct": 1
  },
  {
	"question": "What is the main purpose of editing?",
	"answers": [
	  "To improve clarity and accuracy",
	  "To make writing longer",
	  "To remove punctuation",
	  "To add random ideas"
	],
	"correct": 0
  },
  {
	"question": "Which sentence is a question?",
	"answers": [
	  "Please close the door.",
	  "The game was exciting.",
	  "Where are you going?",
	  "What a beautiful day."
	],
	"correct": 2
  },
  {
	"question": "What is a counterargument?",
	"answers": [
	  "An unrelated opinion",
	  "An argument against another viewpoint",
	  "A paragraph summary",
	  "A spelling correction"
	],
	"correct": 1
  },
  {
	"question": "Which sentence contains direct speech?",
	"answers": [
	  "She said that she was tired.",
	  "'I am tired,' she said.",
	  "They were tired yesterday.",
	  "The teacher explained the task."
	],
	"correct": 1
  },
  {
	"question": "What does 'summarise' mean?",
	"answers": [
	  "To expand every detail",
	  "To explain one word",
	  "To give the main points briefly",
	  "To rewrite exactly"
	],
	"correct": 2
  },
  {
	"question": "Which sentence uses correct grammar?",
	"answers": [
	  "He don't like swimming.",
	  "They was late.",
	  "She doesn't enjoy maths.",
	  "We is going home."
	],
	"correct": 2
  },
  {
	"question": "What is an author's purpose?",
	"answers": [
	  "The font style used",
	  "The reason the author wrote the text",
	  "The title of the book",
	  "The number of pages"
	],
	"correct": 1
  },
  {
	"question": "Which word is a noun?",
	"answers": [
	  "Beautiful",
	  "Jump",
	  "Teacher",
	  "Quickly"
	],
	"correct": 2
  },
  {
	"question": "What does scanning a text involve?",
	"answers": [
	  "Reading slowly for detail",
	  "Searching for specific information",
	  "Ignoring headings",
	  "Memorising paragraphs"
	],
	"correct": 1
  },
  {
	"question": "Which sentence uses commas correctly?",
	"answers": [
	  "After school, we went home.",
	  "After school we, went home.",
	  "After, school we went home.",
	  "After school we went, home."
	],
	"correct": 0
  },
  {
	"question": "What is figurative language?",
	"answers": [
	  "Language that is always literal",
	  "Language using imaginative comparisons",
	  "Scientific terminology only",
	  "A list of facts"
	],
	"correct": 1
  },
  {
	"question": "Which sentence contains exaggeration?",
	"answers": [
	  "I have told you a million times.",
	  "The tree is tall.",
	  "The coffee is hot.",
	  "She arrived early."
	],
	"correct": 0
  },
  {
	"question": "What is the purpose of headings in a text?",
	"answers": [
	  "To confuse readers",
	  "To organise information",
	  "To replace paragraphs",
	  "To provide dialogue"
	],
	"correct": 1
  },
  {
	"question": "Which sentence is an opinion?",
	"answers": [
	  "Earth orbits the Sun.",
	  "Chocolate ice cream tastes best.",
	  "Humans need oxygen.",
	  "Birds have feathers."
	],
	"correct": 1
  },
  {
	"question": "What is a complex sentence?",
	"answers": [
	  "A sentence with one clause only",
	  "A sentence with a dependent and independent clause",
	  "A sentence without punctuation",
	  "A sentence that asks a question"
	],
	"correct": 1
  },
  {
	"question": "Which word best describes formal writing?",
	"answers": [
	  "Casual",
	  "Precise",
	  "Slang-filled",
	  "Messy"
	],
	"correct": 1
  },
  {
	"question": "What is the purpose of evidence in an essay?",
	"answers": [
	  "To weaken the argument",
	  "To support ideas with proof",
	  "To add unrelated details",
	  "To increase word count only"
	],
	"correct": 1
  },
  {
	"question": "Which sentence contains a rhetorical question?",
	"answers": [
	  "What time is it?",
	  "How could anyone disagree?",
	  "Please sit down.",
	  "The sky is blue."
	],
	"correct": 1
  },
  {
	"question": "What is the meaning of 'audience' in writing?",
	"answers": [
	  "The writer's notebook",
	  "The people reading the text",
	  "A punctuation mark",
	  "A type of paragraph"
	],
	"correct": 1
  },
  {
	"question": "Which sentence contains correct apostrophe usage?",
	"answers": [
	  "The dogs bone was buried.",
	  "The dog's bone was buried.",
	  "The dogs' bone was buried.",
	  "The dog's' bone was buried."
	],
	"correct": 1
  },
  {
	"question": "What is a hook in writing?",
	"answers": [
	  "A boring sentence",
	  "An opening designed to grab attention",
	  "A bibliography entry",
	  "A grammar mistake"
	],
	"correct": 1
  },
  {
	"question": "Which sentence uses parallel structure?",
	"answers": [
	  "She likes swimming, biking, and to run.",
	  "She likes swimming, biking, and running.",
	  "She likes swim, biking, and running.",
	  "She likes swimming, to bike, and running."
	],
	"correct": 1
  },
  {
	"question": "What is the purpose of transition words?",
	"answers": [
	  "To connect ideas smoothly",
	  "To replace punctuation",
	  "To create spelling errors",
	  "To shorten essays"
	],
	"correct": 0
  },
  {
	"question": "Which sentence contains imagery?",
	"answers": [
	  "The golden sunlight warmed the quiet beach.",
	  "The beach exists near town.",
	  "People visited the beach.",
	  "The report mentioned beaches."
	],
	"correct": 0
  },
  {
	"question": "What is the meaning of 'bias' in a text?",
	"answers": [
	  "A balanced viewpoint",
	  "A preference influencing opinion",
	  "A grammar rule",
	  "A scientific fact"
	],
	"correct": 1
  },
  {
	"question": "Which sentence is written in passive voice?",
	"answers": [
	  "The chef cooked the meal.",
	  "The meal was cooked by the chef.",
	  "The chef cooks daily.",
	  "The chef will cook tomorrow."
	],
	"correct": 1
  },
  {
	"question": "What is cohesion in writing?",
	"answers": [
	  "Ideas linking together clearly",
	  "Random unrelated paragraphs",
	  "Using no punctuation",
	  "Writing only dialogue"
	],
	"correct": 0
  },
  {
	"question": "Which sentence contains an idiom?",
	"answers": [
	  "It is raining heavily.",
	  "Break a leg before the performance.",
	  "The exam begins tomorrow.",
	  "The river is wide."
	],
	"correct": 1
  }
]

func get_question():
	return questions.pick_random()
