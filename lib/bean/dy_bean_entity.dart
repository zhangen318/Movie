import 'package:movie/generated/json/base/json_convert_content.dart';
import 'package:movie/generated/json/base/json_filed.dart';

class DyBeanEntity with JsonConvert<DyBeanEntity> {
	DyBeanResult result;
	String message;
	String status;
}

class DyBeanResult with JsonConvert<DyBeanResult> {
	int commentNum;
	String duration;
	String imageUrl;
	List<DyBeanResultMovieActor> movieActor;
	List<DyBeanResultMovieDirector> movieDirector;
	int movieId;
	String movieType;
	String name;
	String placeOrigin;
	List<String> posterList;
	int releaseTime;
	double score;
	List<DyBeanResultShortFilmList> shortFilmList;
	String summary;
	int whetherFollow;
}

class DyBeanResultMovieActor with JsonConvert<DyBeanResultMovieActor> {
	String name;
	String photo;
	String role;
}

class DyBeanResultMovieDirector with JsonConvert<DyBeanResultMovieDirector> {
	String name;
	String photo;
}

class DyBeanResultShortFilmList with JsonConvert<DyBeanResultShortFilmList> {
	String imageUrl;
	String videoUrl;
}
