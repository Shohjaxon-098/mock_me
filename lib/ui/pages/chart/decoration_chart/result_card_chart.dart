import '../../../../utils/tools/file_important.dart';
import 'build_section_chart.dart';

class ResultCard extends StatefulWidget {
  final int spSubjectPoint;
  final int mathPoint;
  final int englishPoints;
  final String date;
  final double point;
  final String testCode;

  ResultCard({
    required this.spSubjectPoint,
    required this.mathPoint,
    required this.englishPoints,
    required this.date,
    required this.point,
    required this.testCode,
  });

  @override
  _ResultCardState createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  bool _isExpanded = false;
  final double _cardClosedHeight = 140;
  final double _cardOpenHeight = 207;

  // Dummy data
  final int majburiyFanlarPoints = 20;
  final int matematikaPoints = 15;
  final int xorijiyTilPoints = 10;
  final int totalPoints = 45;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: width(context) * 0.89,
        //height: _isExpanded ? _cardOpenHeight : _cardClosedHeight,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildSectionTitle(
                title: 'Variant ${widget.testCode}',
                isExpanded: _isExpanded,
                onTap: _toggleExpanded,
                iconClosed: Icons.chevron_right,
                iconOpened: Icons.expand_more,
              ),
              if (_isExpanded) ...[
                buildSubject(title: 'Majburiy Fanlar',
                    count: '${widget.spSubjectPoint} ta'),
                buildSubject(
                    title: 'Matematika', count: '${widget.mathPoint} ta'),
                buildSubject(
                    title: 'Xorijiy til', count: '${widget.englishPoints} ta'),
              ],
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Test sanasi:',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'Inter-Medium'
                    ),
                  ),
                  Text(
                    '${widget.date}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'Inter-Medium'
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              buildSecondSection(
                title: 'Umumiy ball',
                count: '${widget.point}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}