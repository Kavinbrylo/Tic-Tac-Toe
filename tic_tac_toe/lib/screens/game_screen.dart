import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String playerSide;
  final bool isAi;

  const GameScreen({Key? key, required this.playerSide, required this.isAi}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  int playerScore = 0;
  int aiScore = 0;
  String playerOneName = 'Player';
  String playerTwoName = 'Ai';

  @override
  void initState() {
    super.initState();
    if (widget.playerSide == 'O' && widget.isAi) {
      currentPlayer = 'X';
      aiMove();
    }
    if (!widget.isAi) {
      playerOneName = 'Player 1';
      playerTwoName = 'Player 2';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
  child: SingleChildScrollView(
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(playerOneName, style: const TextStyle(fontSize: 20, fontFamily: 'KOMIKAX_')),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade400, blurRadius: 30, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Text('$playerScore - $aiScore', style: const TextStyle(fontSize: 20, fontFamily: 'KOMIKAX_')),
                ),
                Text(playerTwoName, style: const TextStyle(fontSize: 20, fontFamily: 'KOMIKAX_')),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.white,
            elevation: 5,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => makeMove(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: index < 6 ? const BorderSide(width: 2, color: Colors.green) : BorderSide.none,
                          right: index % 3 != 2 ? const BorderSide(width: 2, color: Colors.red) : BorderSide.none,
                        ),
                      ),
                      child: Center(
                        child: board[index] == 'X'
                            ? Image.asset('assets/img2.png', width: 80)
                            : board[index] == 'O'
                                ? Image.asset('assets/img1.png', width: 80)
                                : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            winner.isEmpty ? '' : winner,
            style: const TextStyle(fontSize: 24, color: Colors.green, fontFamily: 'KOMIKAX_'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(200, 50),
              padding: const EdgeInsets.symmetric(vertical: 10),
              elevation: 10,
              shadowColor: Colors.grey,
            ),
            onPressed: resetBoard,
            child: const Text(
              'Reset Game',
              style: TextStyle(fontSize: 24, fontFamily: 'KOMIKAX_', color: Colors.black54),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    ),
  ),
),
    );
  }

  void aiMove() {
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = currentPlayer;
        if (checkWinner(currentPlayer)) {
          setState(() {
            winner = '$currentPlayer Wins!';
            aiScore++;
          });
          return;
        }
        board[i] = '';
      }
    }

    String opponent = widget.playerSide;
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = opponent;
        if (checkWinner(opponent)) {
          setState(() {
            board[i] = currentPlayer;
            currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          });
          return;
        }
        board[i] = '';
      }
    }

    if (board[4] == '') {
      setState(() {
        board[4] = currentPlayer;
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      });
      return;
    }

    List<int> corners = [0, 2, 6, 8];
    for (int corner in corners) {
      if (board[corner] == '') {
        setState(() {
          board[corner] = currentPlayer;
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        });
        return;
      }
    }
  }

  void resetBoard() {
    setState(() {
      board = List.filled(9, '');
      winner = '';
      currentPlayer = widget.playerSide == 'O' ? 'X' : 'X';
      if (widget.playerSide == 'O' && widget.isAi) {
        aiMove();
      }
    });
  }

  bool checkWinner(String player) {
    List<List<int>> winpatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var pattern in winpatterns) {
      if (board[pattern[0]] == player &&
          board[pattern[1]] == player &&
          board[pattern[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void makeMove(int index) {
    if (board[index] == '' && winner == '') {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner(currentPlayer)) {
          winner = '$currentPlayer Wins!';
          if (currentPlayer == widget.playerSide) {
            playerScore++;
          } else {
            aiScore++;
          }
        } else if (!board.contains('')) {
          winner = 'Draw!';
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          if (widget.isAi && currentPlayer != widget.playerSide) {
            aiMove();
          }
        }
      });
    }
  }
}
