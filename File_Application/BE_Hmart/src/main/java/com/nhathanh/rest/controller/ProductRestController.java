package com.nhathanh.rest.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.nhathanh.dao.CategoryDAO;
import com.nhathanh.dao.ProductDAO;
import com.nhathanh.entity.Category;
import com.nhathanh.entity.Item;
import com.nhathanh.entity.Product;

@CrossOrigin("*")
@RestController
public class ProductRestController {
	public static final String hmart = "src\\main\\resources\\templates\\FE_Hmart\\File_Local\\Images";
	public static final String File_local = "src\\main\\resources\\templates\\FE_Hmart\\File_Local";
	@Autowired
	CategoryDAO cteDao;

	@Autowired
	ProductDAO prDao;

	@GetMapping("/getAll/categories")
	public List<Category> categories() {
		return cteDao.findAll();
	}

	@GetMapping("/getAll/products")
	public List<Product> getAllProduct() {
		return prDao.findAll();
	}

	@RequestMapping("/getImage/{floder}")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> image(@PathVariable("floder") String folder) throws FileNotFoundException {
		File[] children = new File(hmart + "\\" + folder).listFiles();
		String nameFile = "";
		if (children != null) {
			for (int i = 0; i < children.length; i++) {
				if (children[i].getName().contains("main")) {
					nameFile = children[i].getName();
					break;
				}
			}
		}
		try {
			Path filename = Paths.get(hmart + "\\" + folder, nameFile);
			byte[] buffer = Files.readAllBytes(filename);
			ByteArrayResource bar = new ByteArrayResource(buffer);
			return ResponseEntity.ok().contentLength(buffer.length).contentType(MediaType
					.parseMediaType("image/" + nameFile.substring(nameFile.indexOf(".") + 1, nameFile.length())))
					.body(bar);
		} catch (Exception e) {
			System.out.println(e);
		}
		return ResponseEntity.badRequest().build();
	}

	@PostMapping("/create/product")
	public Product create(@RequestBody Product pd) {
		System.out.println(pd);
		return prDao.save(pd);
	}

	@GetMapping("/getId/product/{id}")
	public Product getId(@PathVariable("id") Integer idProduct) {
		return prDao.findById(idProduct).get();
	}

	// If floder not exits auto create
	public String createFloder(String path) {
		File uploadRootDir = new File(path);
		if (!uploadRootDir.exists()) {
			uploadRootDir.mkdirs();
		}
		return path;
	}

	// Get list sub image form name folder
	@GetMapping("/getImage/subImage/{floder}")
	@ResponseBody
	public ArrayList<File> getSubImage(@PathVariable("floder") String nameFolder) throws IOException {
		ArrayList<File> ds = new ArrayList<File>();
		File[] children = new File(hmart + "\\" + nameFolder).listFiles();
		if (children != null) {
			for (int i = 0; i < children.length; i++) {
				if (!children[i].getName().contains("main")) {
					ds.add(children[i]);
				}
			}
		}
		return ds;
	}

	// Get list sub image form name folder
	@GetMapping("/getImage/mainImage/{floder}")
	@ResponseBody
	public File getMainImage(@PathVariable("floder") String nameFolder) throws IOException {
		File[] children = new File(hmart + "\\" + nameFolder).listFiles();
		File mainImage = new File("src\\main\\resources\\templates\\FE_Hmart\\File_Local\\icon\\no_image_300_300.jpg");
		if (children != null) {
			for (int i = 0; i < children.length; i++) {
				if (children[i].getName().contains("main")) {
					mainImage = children[i];
					return mainImage;
				}
			}
		}
		return mainImage;
	}

	// Save images
	@PostMapping("/uploadImages")
	public String postImage(@RequestParam("listImages[]") ArrayList<MultipartFile> object,
			@RequestParam("nameFloder") String nameFoloder, @RequestParam("main-img") MultipartFile imgMain)
			throws IOException {
		// Save main img
		saveImage(imgMain, nameFoloder, "main");
		String unid = UUID.randomUUID().toString();
		// Save sub img
		if (object != null) {
			try {
				for (int i = 0; i < object.size(); i++) {
					saveImage(object.get(i), nameFoloder,String.valueOf(i));
				} 
				System.out.println("Save file successfully!");
				// Return name floder
				return nameFoloder;
			} catch (Exception e) {
				System.out.println(e);
				return "Error!";
			}
		}
		return "Error";
	}

	// Update product
	@PutMapping("/update/product")
	public Product updateProduct(@RequestBody Product pr) {
		return prDao.save(pr);
	}

	// Update main image
	@PutMapping("/update/main-image/product")
	public String updateMainImage(@RequestParam("main-img") MultipartFile imgMain,
			@RequestParam("nameFloder") String nameFolder) throws IOException {
		File[] children = new File(hmart + "\\" + nameFolder).listFiles();
		try {
			if (children != null) {
				for (int i = 0; i < children.length; i++) {
					if (children[i].getName().contains("main")) {
						children[i].delete();
						// Save new main img
						saveImage(imgMain, nameFolder, "main");
						System.out.println("Update main image successfully!");
						return "OK";
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return "Error";
	}



	// Method save images
	public void saveImage(MultipartFile file, String nameFolder, String nameFile) throws IOException {
		Path path = Paths.get(createFloder(hmart + "\\" + nameFolder));
		try {
			if (file != null) {
				// Get name file MultipartFile
				String fileNameMain = file.getOriginalFilename().trim();
				// Get type file(jpg,png,...) MultipartFile
				String typeImage = fileNameMain.substring(fileNameMain.indexOf("."), fileNameMain.length());
				// Set file name and save with name file...;
				String nameImage = String.valueOf(nameFile + typeImage);
				InputStream inputStream = file.getInputStream();
				Files.copy(inputStream, path.resolve(nameImage), StandardCopyOption.REPLACE_EXISTING);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	// Remove sub-image
		@PostMapping("/update/product/sub-image")
		public void updateProduct(@RequestBody ArrayList<String> object) throws IOException {
			for (int i = 0; i < object.size(); i++) {
				String fileName = object.get(i);
				System.out.println(fileName);
		        try {
		            boolean result = Files.deleteIfExists(Paths.get("src\\main\\resources\\templates\\FE_Hmart\\File_Local\\"+fileName));
		            if (result) {
		                System.out.println("File is deleted!");
		            } else {
		                System.out.println("Sorry, unable to delete the file.");
		            }
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
			}
		}

		// Update sub-image
		@PostMapping("/update/product/new/sub-image")
		public String updateNewSubImage(@RequestParam("listImages[]") ArrayList<MultipartFile> object,
				@RequestParam("nameFloder") String nameFolder) throws IOException {
			if (object != null) {
				System.out.println(object.size() + " tong file update");
				try {
					for (int i = 0; i < object.size(); i++) {
						saveImage(object.get(i), nameFolder,String.valueOf(i)); 
					}
					System.out.println("Save file successfully!");
					// Return name floder
					return nameFolder;
				} catch (Exception e) {
					System.out.println(e);
					return "Error!";
				}
			}
			return nameFolder;
		}
	/////////////// Trần Phạm Phi Hùng

	@Autowired
	ProductDAO productDao;

	@GetMapping("/hfn/product/getAll")
	public List<Product> getAll() {
		return productDao.findAll();
	}

	@GetMapping("/hfn/product/{id}")
	public Product getOne(@PathVariable("id") Integer id) {
		return productDao.findById(id).get();
	}

	@GetMapping("/hfn/product/cate/{id}")
	public List<Product> getByCate(@PathVariable("id") String id) {
		return productDao.findByCategoryId(id);
	}

	@GetMapping("/hfn/item/{id}")
	public Item getItem(@PathVariable("id") Integer id) {
		Item item = new Item();
		BeanUtils.copyProperties(productDao.findById(id).get(), item);
		return item;
	}

}
