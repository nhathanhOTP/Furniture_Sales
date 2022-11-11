package com.nhathanh.until;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Iterator;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class SaveFileRestController {
	public static final String hmart = "src\\main\\resources\\templates\\FE_Hmart\\File_Local\\Images";

	// If floder not exits auto create
	public String createFloder() {
		File uploadRootDir = new File(hmart);
		if (!uploadRootDir.exists()) {
			uploadRootDir.mkdirs();
		}
		return hmart;
	}

	

//	// Api get all image
//	@GetMapping("/getAllImage")
//	public ArrayList<String> getAll() { 
//		File[] children = new File(hmart).listFiles();
//		ArrayList<String> ds = new ArrayList<String>();
//		for (int i = 0; i < children.length; i++) {
//			ds.add(children[i].getName());
//		}
//		return ds;
//	}

	// Return Image
	public ResponseEntity<ByteArrayResource> getImage(String file) {
		try {
			Path filename = Paths.get(hmart, file);
			byte[] buffer = Files.readAllBytes(filename);
			ByteArrayResource bas = new ByteArrayResource(buffer);
			return ResponseEntity.ok().contentLength(buffer.length)
			.contentType(MediaType.parseMediaType("image/" + file.substring(file.indexOf(".") + 1, file.length())))
			.body(bas);
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
	}
	//Method create floder
	public String createFloder(String florder) {
		File uploadRootDir = new File(florder);
		if (!uploadRootDir.exists()) {
			uploadRootDir.mkdirs();
		}
		return uploadRootDir.getAbsolutePath(); 
	}
}
