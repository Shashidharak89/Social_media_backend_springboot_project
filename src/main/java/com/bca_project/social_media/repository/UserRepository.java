package com.bca_project.social_media.repository;

import com.bca_project.social_media.model.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface UserRepository extends MongoRepository<User, String> {
    // Custom Query Example (Optional)
    List<User> findByFirstName(String firstName);
}
