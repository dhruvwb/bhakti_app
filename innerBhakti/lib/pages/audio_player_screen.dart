import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:inner_bhakti/pages/program_list_screen.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayer();
  }

  Future<void> _initializeAudioPlayer() async {
    await assetsAudioPlayer.open(
      Audio("assets/songs/ram.mp3"),
      autoStart: false,
    );

    assetsAudioPlayer.currentPosition.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });

    assetsAudioPlayer.current.listen((playingAudio) {
      setState(() {
        totalDuration = playingAudio?.audio.duration ?? Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.orange,
        body: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: _buildBody(screenSize),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.orange,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            assetsAudioPlayer.stop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProgramListScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody(Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Raam Naam Jaap',
          style: TextStyle(
            fontSize: screenSize.width * 0.075,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: screenSize.height * 0.01),
        _buildDescription(screenSize),
        SizedBox(height: screenSize.height * 0.05),
        _buildImage(screenSize),
        SizedBox(height: screenSize.height * 0.03),
        _buildControls(screenSize),
      ],
    );
  }

  Widget _buildDescription(Size screenSize) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
        child: Text(
          'Feel better by listening \n to this recommended jaap',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenSize.width * 0.03,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(Size screenSize) {
    return Image.asset(
      'assets/images/image.jpeg',
      height: screenSize.height * 0.35,
    );
  }

  Widget _buildControls(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          _buildTrackInfo(screenSize),
          _buildSlider(),
          _buildDurationRow(),
          _buildPlayPauseButton(),
        ],
      ),
    );
  }

  Widget _buildTrackInfo(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Raam Naam Jaap',
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Shri Raam',
              style: TextStyle(
                fontSize: screenSize.width * 0.04,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.favorite_border, color: Colors.black),
            SizedBox(width: 10),
            Icon(Icons.share, color: Colors.black),
          ],
        ),
      ],
    );
  }

  Widget _buildSlider() {
    return Slider(
        value: currentPosition.inSeconds.toDouble(),
        min: 0,
        max: totalDuration.inSeconds.toDouble(),
        activeColor: Colors.black,
        inactiveColor: Colors.grey,
        onChanged: (value) {
          setState(() {
            assetsAudioPlayer.seek(
                Duration(seconds: value.toInt())); // Seek to the new position
          });
        });
  }

  Widget _buildDurationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${formatDuration(currentPosition)}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        Text(
          '${formatDuration(totalDuration)}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayPauseButton() {
    return StreamBuilder(
      stream: assetsAudioPlayer.isPlaying,
      builder: (context, snapshot) {
        bool isPlaying = snapshot.data ?? false;

        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow, // Yellow background
          ),
          padding: EdgeInsets.all(1.0), // Padding around the icon
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {
              assetsAudioPlayer.playOrPause();
            },
          ),
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
