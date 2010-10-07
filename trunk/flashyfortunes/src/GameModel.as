package
{
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;

	public class GameModel
	{
		
		static public var LEFT_TEAM : int = 0; 
		static public var RIGHT_TEAM : int = 1; 

		static public var STATE_PRE_PLAY : int = 0; 
		static public var STATE_BUZZER_LOCKOUT : int = 1; 
		static public var STATE_HEAD_TO_HEAD : int = 2; 
		static public var STATE_IN_PLAY : int = 3; 
		static public var STATE_TIE_BREAKER : int = 4; 
		static public var STATE_ROUND_OVER : int = 5; 
		
		static public var stateNames : Array = ["PRE_PLAY","BUZZER_LOCKOUT", "HEAD_TO_HEAD", "IN_PLAY", "TIE_BREAKER", "ROUND_OVER"]; 
		
		public var rounds : Array = new Array(); 
		//public var score1 : int = 0; 
		//public var score2 : int = 0; 
		public var scores : Array = [0,0]; 
		
		public var wrongSound : Sound ; 
		public var rightSound : Sound; 
		public var buzzerSound : Sound; 
		public var themeSting : Sound; 
		public var theme : Sound; 
		
		public var currentRoundIndex : int = 0; 
		
		public var currentTeam :int = LEFT_TEAM; 
		public var firstPressed : int = -1; 
		
		public var wiiManager : WiimoteManager; 
		
		
		
		public function GameModel()
		{
			
			var round : RoundData; 
			
			/*
			FLASHY FORTUNES QUESTIONS : 
			
			round = new RoundData(); 
			
			round.question = "A tech/language they will learn within a year"; 
			
			round.addLabel("Unity3D", 88);
			round.addLabel("iOS/Obj C", 82); 
			round.addLabel("JavaScript", 73);
			round.addLabel("OpenFrameworks", 65);
			round.addLabel("Processing", 22);
			round.addLabel("ActionScript", 42);
			
			
			rounds.push(round); 
			
			round = new RoundData(); 
			
			round.question = "A reason to hate Flash"; 
			round.addLabel("Poor Performance", 130); 
			round.addLabel("Crashes", 111, "Crashes, unreliable"); 
			round.addLabel("Poor UX", 101, "Poor UX, abuse");
			round.addLabel("Unfamiliar", 95);
			round.addLabel("Closed/Proprietary", 91);
			round.addLabel("Load times", 80, "Load times, load progress bars");
			
			
			
			
			rounds.push(round); 
			
			round = new RoundData(); 
			
			round.question = "a reason Jobs posted Thoughts on Flash"; 
			
			round.addLabel("AppStore Revenue", 222); 
			round.addLabel("Emotional response", 129);
			round.addLabel("Flash Performance", 112); 
			round.addLabel("Battery Usage", 109); 
			round.addLabel("Security", 65); 
			round.addLabel("Usability", 65); 
			
			rounds.push(round); 
				
			*/
			
			
			//BARCAMP BRIGHTON QUESTIONS : 
			
			
	
			round = new RoundData(); 
			
			round.question = "Name something (apart from your laptop) that you would put in your laptop bag"; 
			
			round.addLabel("Power supply", 25); 
			round.addLabel("Mouse", 19); 
			round.addLabel("Snacks/Lunch", 12); 
			round.addLabel("Note pad", 8); 
			round.addLabel("Cables", 6); 
			round.addLabel("iPad", 5); 
			
			rounds.push(round); 
			
			
			
			
			
			round = new RoundData(); 
			
			round.question = "A thing you would do on the internet"; 
			
			round.addLabel("Porn", 21); 
			round.addLabel("Surf", 12); 
			round.addLabel("Email", 10); 
			round.addLabel("Tweet", 9); 
			round.addLabel("Shopping", 7); 
			round.addLabel("Waste time", 6); 
			
			rounds.push(round); 
			
			
			
			round = new RoundData(); 
			
			round.question = "A brand of computer"; 
			
			round.addLabel("Apple", 42); 
			round.addLabel("Dell", 21); 
			round.addLabel("Acer", 5); 
			round.addLabel("Acorn", 5); 
			round.addLabel("Alienware", 4); 
			round.addLabel("Sinclair", 4); 
			
			rounds.push(round); 
			
			
			
			round = new RoundData(); 
			
			round.question = "Name a reason to turn on private browsing "; 
			
			round.addLabel("Porn", 74); 
			round.addLabel("Buying Gifts", 11); 
			round.addLabel("Banking", 4); 
			round.addLabel("Espionage/Paranoia", 4); 
			round.addLabel("Stalking", 1); 
			round.addLabel("Looking up diseases", 1); 
			
			rounds.push(round); 
			
			
			
			round = new RoundData(); 
			
			round.question = "Name a Star Wars character"; 
			
			round.addLabel("Chewy", 17); 
			round.addLabel("R2D2", 12); 
			round.addLabel("Yoda", 8); 
			round.addLabel("Han Solo", 8); 
			round.addLabel("Darth Vader", 8); 
			round.addLabel("Boba Fet", 8); 
			
			rounds.push(round); 
			
			
			round = new RoundData(); 
			
			round.question = "A Geek Gadget"; 
			
			round.addLabel("iPhone", 46); 
			round.addLabel("iPad", 22); 
			round.addLabel("mobile phone (non-apple)", 11); 
			round.addLabel("Digital watch", 3); 
			
			rounds.push(round); 
			
			
			
			round = new RoundData(); 
			
			round.question = "Name a Brighton User group"; 
			
			round.addLabel("dotBrighton", 25); 
			round.addLabel("The Farm", 15); 
			round.addLabel("BuildBrighton", 5); 
			round.addLabel("UXBrighton", 4); 
			round.addLabel("Async", 3); 
			round.addLabel("£5 App", 3); 
			
			rounds.push(round); 
			
			
			
			
			round = new RoundData(); 
			
			round.question = "Application to create web content"; 
			
			round.addLabel("Flash", 26); 
			round.addLabel("Text editor", 24); 
			round.addLabel("Dreamweaver", 21); 
			round.addLabel("Wordpress", 8); 
			round.addLabel("Word", 6); 
			round.addLabel("Photoshop", 3); 
			
			rounds.push(round); 
			
			
		
			
			round = new RoundData(); 
			
			round.question = "Name something you would keep on your desk"; 
			
			round.addLabel("Coffee/Tea mug", 18); 
			round.addLabel("note pad/Post-its", 11); 
			round.addLabel("Pen/Pencil", 10); 
			round.addLabel("Toys/Figures", 9); 
			round.addLabel("Energy/soft drink/water", 8); 
			round.addLabel("Keyboard", 8); 
			
			rounds.push(round); 
			
			
			
			
			round = new RoundData(); 
			
			round.question = "Name a well known Brighton company"; 
			
			round.addLabel("Plug-in Media", 24); 
			round.addLabel("ClearLeft", 21); 
			round.addLabel("Future Platforms", 7); 
			round.addLabel("Ribot", 5); 
			round.addLabel("CogApp", 4); 
			round.addLabel("NixonMcInnes", 4); 
			
			rounds.push(round); 
			
			
				
			round = new RoundData(); 
			
			round.question = "Name a popular internet Meme"; 
			
			round.addLabel("Lolcats", 27); 
			round.addLabel("Rickroll", 10); 
			round.addLabel("All your base", 6); 
			round.addLabel("Goat.se", 5); 
			round.addLabel("Keyboard cat", 3); 
			round.addLabel("Double rainbow", 3); 
			
			rounds.push(round); 
			
			
			
			
			
			
			
			
			currentRoundIndex =0;
			
			wrongSound = new WrongSND(); 
			rightSound = new DingSND(); 
			buzzerSound = new BuzzerSND(); 
			theme = new ThemeSND(); 
			themeSting = new ThemeStingSND(); 
			
			wiiManager = new WiimoteManager(wiiPressed); 
			
			
			
		}
		
		
		public function connect() : void
		{
			wiiManager.connect();
			
		}
		
		public function get currentRound () : RoundData
		{
			return rounds[currentRoundIndex]; 
		}
		
		public function wrong() : void
		{
			if(currentRound.inPlay) 
			{
				currentRound.incWrongCount(currentTeam); 
				wrongSound.play(); 
				Scoreboard.instance.updateBoardContent();
			}
			trace(currentTeam, currentRound.wrongCounts[currentTeam?0:1]);
			
			
			if(state==STATE_BUZZER_LOCKOUT) 
				setState(STATE_HEAD_TO_HEAD);
			
			if(state == STATE_HEAD_TO_HEAD)
			{
				switchTeams(); 
				currentRound.resetWrongs(currentTeam);
				//if last team already got a right answer they can play!
				
				if(currentRound.lastRevealed) 
					startPlay(); 
				else
					updateState(); 
				
			}
			// IF all 3 Xs are lost and the other team hasn't had a go, then switch teams!
			else if(state == STATE_IN_PLAY)
			{
				if(currentRound.wrongCount(currentTeam)==3)
				{
					switchTeams(); 
					setState(STATE_TIE_BREAKER);
					
					
				}
			}
			else if(state==STATE_TIE_BREAKER)
			{
				// other team wins!
				switchTeams(); 
				roundOver(); 
			}
			
			
			// if current team has got a wrong answer and the other team has lost all their lives then 
			// the first team wins and we move to the next round. 
			if((currentRound.wrongCount(currentTeam)>0) && 
				(currentRound.wrongCount(otherTeam)==3))
			{
				// END OF ROUND!
				//currentRound.inPlay = false; 
					
			}
			
			
			
		}
		
		public function revealAnswer(answerNum : int ) : Boolean
		{
			if(currentRound.items.length<=answerNum) return false;
			if(state==STATE_PRE_PLAY) return false; 
			
			var itemData : ItemData = currentRound.items[answerNum] as ItemData; 
			
			if(!itemData.revealed)
			{
				itemData.revealed = true;
				currentRound.revealCount ++; 
				
				if(currentRound.inPlay) currentRound.total+=itemData.num; 
				
				if(state==STATE_BUZZER_LOCKOUT)
					setState(STATE_HEAD_TO_HEAD);
				
				if(state == STATE_HEAD_TO_HEAD)
				{
					//if other team have already fucked it then or this is top answer
					// currentTeam are in play!
					if((currentRound.wrongCount(otherTeam)>0) || (itemData.index==0))
					{
						// current Team in play
						startPlay(); 
					}
					// otherwise if there is already a revealed answer we check 
					// if this is higher or lower
					else if (currentRound.lastRevealed)
					{
						//if it's higher then we switch teams 
						if(currentRound.lastRevealed.index<itemData.index)
						{
							switchTeams();
						}
						// either way we're in play
						startPlay(); 
						
						
					}
					// if we get an answer lower than one then other team tries
					else
					{
						
						switchTeams(); 
						currentRound.resetWrongs(currentTeam); 
						
					}
					updateState(); 
						
				}
				
				else if(state == STATE_IN_PLAY)
				{
					// if all answers found then round finished! 
					if(currentRound.revealCount == currentRound.items.length)
					{
						roundOver(); 
					}
					
				}
				// new team has stolen it! 
				else if(state == STATE_TIE_BREAKER)
				{
					roundOver(); 
					
					
				}
				rightSound.play(200); 
				
				currentRound.lastRevealed = itemData;
				
				
				
				return true; 
				
			}
			else
			{
				return false; 	
			}
			
		}
		public function startPlay() : void
		{
			currentRound.resetWrongs(currentTeam);
			currentRound.resetWrongs(otherTeam);
			setState(STATE_IN_PLAY);
		}
		public function switchTeams() : void
		{
			if(currentTeam<0) currentTeam = LEFT_TEAM; 
			else currentTeam = otherTeam; 
		
			updateState();
			trace("SWITCH TEAMS! ", currentTeam); 
		}
		public function roundOver() : void
		{
			scores[currentTeam]+=currentRound.total;
			//currentRound.total = 0; 
			themeSting.play(); 
			
			setState(STATE_ROUND_OVER);
			updateState(); 
			Scoreboard.instance.familyLight(currentTeam, true, true); 
		}
		public function nextRound() : Boolean
		{
			if(currentRoundIndex<rounds.length-1) 
			{
				currentRoundIndex++; 
				currentRound.reset(); 
				currentTeam = -1; 
				setState(STATE_PRE_PLAY);
				
				
				return true; 
			}
			else return false; 
			
		
		}
		public function resetRound() : void
		{
			firstPressed = -1; 
			//currentRound.reset();  
			currentTeam = -1; 
			setState(STATE_PRE_PLAY);
			updateState(); 
			Scoreboard.instance.updateDisplay();
			
		}
		public function prevRound() : Boolean
		{
			if(currentRoundIndex>0) 
			{
				currentRoundIndex--; 
				currentTeam = -1; 
				//currentRound.reset(); 
				updateState(); 
				return true; 
			}
			else return false; 
			
			
		}
		
		
		public function lockoutToggle(e : MouseEvent = null) : void
		{
			if(state == STATE_BUZZER_LOCKOUT)
			{
				setState(STATE_HEAD_TO_HEAD);
				if(currentTeam<0) currentTeam = LEFT_TEAM;
				
			}
			else if((state== STATE_HEAD_TO_HEAD)||(state== STATE_PRE_PLAY))
			{
				setState(STATE_BUZZER_LOCKOUT);
				
			}
		
			
		}
		
		public function get state() : int 
		{
			return currentRound.state;	
		}
		public function setState(s :int) : void 
		{
			if(s==STATE_BUZZER_LOCKOUT) 
			{
				firstPressed = -1; 
				currentTeam = -1;
				
			}
			currentRound.state = s;	
			updateState(); 
		}
		
		public function updateState() : void
		{
			Scoreboard.updateState();
			ControlPanel.updateState();
				
		}
		public  function buzzerPress (teamLight : int, pressed : Boolean) : void
		{
			if(state!=STATE_BUZZER_LOCKOUT)
			{
				Scoreboard.instance.familyLight(teamLight, pressed);
				//if(teamLight==0) light1 = pressed; 
				//else light2 = pressed; 
			}
			else if(pressed)
			{
				if(firstPressed == -1)
				{
					//NOISE!
					firstPressed = teamLight;
					currentTeam = teamLight;
					updateState(); 
					Scoreboard.instance.familyLight(teamLight, true);
					var sndTransform : SoundTransform = new SoundTransform(1,(teamLight==0)?-1:1); 
					buzzerSound.play(0,0,sndTransform); 
					
					
				}
					
				
			}
		
		}
		
		public function get otherTeam() : int 
		{
			return Math.abs(currentTeam-1); // subtract 1 from team which makes team 1 into team 0 and team 0 into team -1 == 1. 
		}
		
		
		public function wiiPressed(index : int, state : Boolean) : void
		{
			ControlPanel.instance.wiiLight(index,state);
			var teamLight : int = ControlPanel.instance.getTeamForIndex(index);
			if(teamLight>=0)
			{
				buzzerPress(teamLight, state); 
				
			}
		}
		
	}
}