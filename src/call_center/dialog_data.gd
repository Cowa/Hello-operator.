extends Node

var neutral_dialogs = [
	[
		# Reference for size
		"Hello operator, I'd like to call XXXX please. Thanks in advance. Good day",
	],
	[
		"Greetings operator! Hope you're feeling well.",
		"I would really like to call XXXX please."
	],
	[
		"Err- what? ... [baby crying] ... Oh come on!",
		"Huh - sorry operator. Hello. I'm calling XXXX please."
	],
	[
		"XXXX please."
	],
	[
		"Hello operator... I'd like to call... errr- let me find my notes.",
		"... [paper sounds] ...",
		"I found it! XXXX please."
	],
	[
		"Hello operator. XXXX por favor.",
	],
	[
		"[cat meowing] ... [cat meowing] ... Hello operator- [cat meowing]",
		"Sorry about my cat, she likes to talk a lot- [cat meowing] Anyway...",
		"Can you connect me with XXXX please? Have a good day."
	],
	[
		"He-Hello operator. I'm looking to contact XXXX. Can you help me?"
	],
	[
		"Hi operator. I'm waiting to be contacted by a company...",
		"I'm scared that they forget about me... It would not be the first time",
		"So anyway, I'd like to contact them. Their number is XXXX. Thanks"
	],
	[
		"Bonjour opérateur. Can you connect me with- [static noises] -errr...",
		"connect [static noises] XXXX. Please operator- [static noises]"
	],
	[
		"Hey operator, pass me to XXXX. He is expecting me ASAP. Thanks."
	],
	[
		"Hello operator. Is your work hard? It must be exhausting to listen...",
		"... all of these incoming calls. I can't imagine how it is.",
		"Apologies for the disturbance... I'm calling XXXX please."
	],
	[
		"Hi. XXXX."
	],
	[
		"[inaudible voice] ... XXXX."
	],
	[
		"Hello operator. Who are you defenders of the universe? It's cold here.",
		"I heard horrible things these days... Can you link me with XXXX ? Please."
	],
	[
		"Hello ope-ope-ope-rator. Please-eee. XXXX th-ank you."
	],
	[
		"[distant siren] Hello operator, connect me with XXXX please."
	],
	[
		"Good day operator. It's been a while since I used a phone.",
		"So I need to tell you the contact number. That's it? Okay... [silence]",
		"Okay... If I'm not wrong... this should be XXXX. Thanks I guess."
	],
	[
		"Hello operator. The weather is terrible! It's been a while since...",
		"the sun showed its light through the smoke...",
		"But that not the point of my call. Can you connect me to XXXX, please?"
	],
	[
		"Hello operator. The smoke is getting bigger these days... don't know if...",
		"I should be worried... Well. Can you pass me through XXXX please? [coughing]"
	],
	[
		"Good day operator. Last night was a surprisingly calm around here.",
		"Victory is near maybe? I hope so...",
		"Oh sorry, I'm calling XXXX please. War will not divide us."
	],
	[
		"Hello operator. What a week. Everything was so peaceful back there...",
		"[sobbing] I'd like to contact my brother on line XXXX... please."
	],
	[
		"Hello operator. You are lucky to be working nowadays operator.",
		"With the smoke getting thicker and thicker everyday, the future seems...",
		"... uncertain [coughing]. Well. I'm calling XXXX."
	],
	[
		"Operator. XXXX please. And hurry."
	],
	[
		"Greetings from- [static noise]- I'd like to contact XXXX. Please operator."
	],
	[
		"Hola operator. Is this the call center from- [static noise]-?",
		"Okay... thank you. You can link me to XXXX."
	],
	[
		"[whispering] hello... I'm calling XXXX please. [silence]"
	],
	[
		"[yelling] HELLO OPERATOR. XXXX PLEASE. [coughing] ... [coughing]"
	],
	[
		"Finally operator! Can't you be faster? I've been waiting 1 hour...",
		"[coughing] Connect me with XXXX. Now. Seriously."
	],
	[
		"Hello operator. I think I forgot how the sun looks like... Is it bad?",
		"... [coughing] nevermind [coughing]. I'm calling [coughing] XXXX."
	],
	[
		"Hello operator. Lines must be saturated. It's no surprise since the war.",
		"The militia is everywhere... I hope they are really trying to help us...",
		"Well... I'm calling XXXX, please operator."
	]
]

var resistance_dialogs = [
	[
		# Reference for size
		"Hello operator, I'd like to call XXXX please. Thanks in advance. Good day",
	],
	[
		"... [sobbing] ... please help me... [sobbing]",
		"The militia broke into my home last night... [sobbing] My daughter...",
		"[sobbing] I can't find my daughter...",
		"I need to know if she's alright... let me call XXXX please [sobbing]"
	],
	[
		"Hello operator. This is government propaganda, I'm calling XXXX please."
	],
	[
		"Hi operator, I'm calling XXXX. My call is waiting."
	],
	[
		"Hello operator. [dog barking] ... This is an emergency, listen to me.",
		"The government is taking over- [rifle shots] ...",
		"No! ... [explosion] ... [continous rifle shots] ...",
		"... [silence] ..."
	],
	[
		"Hello operator. XXXX please."
	],
	[
		"Good day operator, I'm trying to contact a doctor for my mother.",
		"Could you connect me with XXXX please? Thanks."
	],
	[
		"Operator. A hospital need to be evacuated... a gas leak.",
		"But over there, they have no idea. Please let me call XXXX."
	],
	[
		"Hello operator. Can you connect me with XXXX please?"
	],
	[
		"Hello operator, I'm calling... [distant voices] ... [distance laughs]",
		"Oh sorry about that. I'm calling XXXX please."
	],
	[
		"[clicking sounds] ... Hello operator. I'd like to call XXXX if possible."
	],
	[
		"[distant coughing] Hello operator. This is important. A stock of food...",
		"... must be delivered to a school. Let me contact XXXX please."
	],
	[
		"Operator. The militia is blocking a bridge near- [static noise]-",
		"We can't transport medecine [coughing] and gas masks... [coughing]",
		"Please help us. I need to call XXXX."
	],
	[
		"Hello operator. The smoke is getting really toxic. We need to warn...",
		"a city near the frontier. Let me call XXXX please. [coughing]"
	],
	[
		"Hi operator. Can you pass me through XXXX please? Thank you operator."
	],
	[
		"[distant screaming] We need back up here! Please operator...",
		"The militia is everywhere wearing those masks. [coughing]",
		"Help us. We really need to call XXXX."
	],
	[
		"Hello operator. An ally' ship is coming to the- [static noise]- port...",
		"But this info was leaked. The militia is preparing an assault.",
		"We need to warn our ally. Let me call XXXX. Please operator."
	],
	[
		"Hello operator. Sorry no time to waste. Link me to XXXX."
	],
	[
		"Operator. The coal mine was a trap... I repeat. The coal mine was a trap.",
		"More people must be warned. Pass me to XXXX. Hurry operator!"
	],
	[
		"Hello operator. We found a doctor. We need to alert a city near the port.",
		"Let me call XXXX por favor."
	],
	[
		"Good day operator. Water is missing around here... The militia burned it.",
		"We need water ASAP. Connect me to XXXX. Please."
	],
	[
		"[coughing] [sobbing] Please operator let me contact XXXX."
	],
	[
		"Operator! The militia is taking over- [static noise] -please",
		"I really need- [rifle shots] -oh god- to call XXXX."
	],
	[
		"Hello operator... this may be my last call... Please.",
		"... please let me call XXXX. I can't find my father [sobbing]"
	],
	[
		"[crying] The river has been infected by the smoke.",
		"What the hell! [coughing]. The farm- [static noise] - must...",
		"... be warned. Connect me to XXXX. Please!"
	]
]

var propaganda_dialogs = [
	[
		"Hello operator. This is government propaganda, I'm calling XXXX please."
	],
	[
		"Operator. Connect me with XXXX."
	],
	[
		"[coughing] ... [coughing] ... [coughing]",
		"Sorry operator. [intense coughing] ... XXXX please [coughing]"
	],
	[
		"Hello operator. It's been a long day... well you don't care I guess.",
		"Let me contact XXXX please"
	],
	[
		"Operator. Propaganda officer speaking. [distant voices]",
		"Connect me with XXXX please."
	],
	[
		"Operator... yes it's me again. XXXX please operator."
	],
	[
		"Ha-ha and yet they feel protected! [distant laughs and voices] - ha-ha",
		"Oh- Sorry operator [laughs continue] ... XXXX please."
	],
	
]