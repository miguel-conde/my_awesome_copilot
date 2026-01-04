---
description: 'Python coding standards and best practices for this workspace'
applyTo: '**/*.py'
---

# Python Development Guidelines

## General Instructions

- Follow PEP 8 style guide religiously for all Python code
- Use PEP 257 conventions for all docstrings
- Type hints are mandatory for all functions, methods, and class attributes
- Prefer object-oriented programming patterns by default
- Apply appropriate design patterns when they improve code clarity and maintainability
- Document every module, class, method, and function without exception
- Use pytest as the primary testing framework

## Use of _emojis_
- Avoid _emojis_ in production code, variable names, or function names
- Never use _emojis_ in commit messages or version control history
- Never use _emojis_ in any user-facing messages or logs
- Never use _emojis_ in code that will be parsed by other tools or systems
- Never use _emojis_ in configuration files or environment variables
- Never use _emojis_ in any formal documentation or specifications
- Never use _emojis_ in any code that requires strict compliance or auditing

## Code Style and Formatting

- Maintain 4-space indentation consistently
- Limit lines to 79 characters maximum
- Use descriptive variable and function names in snake_case
- Use CamelCase for class names
- Use UPPER_CASE for constants
- Place imports at the top in order: standard library, third-party, local modules
- Separate import groups with blank lines
- Use blank lines to separate functions, classes, and logical code blocks

## Type Hinting Requirements

- Include type hints for all function parameters and return values
- Use `typing` module imports: `List`, `Dict`, `Optional`, `Union`, `Callable`
- For Python 3.9+, prefer built-in generics: `list`, `dict` instead of `List`, `Dict`
- Use `Optional[T]` for parameters that can be None
- Include type hints for class attributes using annotations
- Use `TypeVar` for generic type parameters when creating reusable components

```python
from typing import Optional, List, Dict, Union
from pathlib import Path

def process_data(
    input_path: Path, 
    output_format: str = "json",
    options: Optional[Dict[str, Union[str, int]]] = None
) -> List[Dict[str, str]]:
    """Process data from input file and return structured results."""
    pass
```

## Documentation Standards

### Module Documentation
- Every module must start with a module-level docstring
- Include purpose, key classes/functions, and usage examples

```python
"""
Data quality audit configuration management.

This module provides Pydantic models and validation logic for configuring
data quality audit processes. It supports multiple data sources including
CSV files, PostgreSQL, SQLite, and custom data loading configurations.

Key Components:
    - DataSourceConfig: Main configuration for data sources
    - TableConfig: Individual table configuration
    - LoadingConfig: Data loading and validation settings

Example:
    config = DataSourceConfig(
        source_type="csv",
        tables={"customers": TableConfig(name="customers", query="SELECT * FROM 'data.csv'")},
        audit_scope={"objective": "Data validation"}
    )
"""
```

### Class Documentation
- Document class purpose, key attributes, and typical usage patterns
- Include examples in docstrings for complex classes

```python
class AuditDataSource:
    """
    Unified data source connector for quality audit processes.
    
    This class provides a consistent interface for connecting to various
    data sources including CSV files, databases, and APIs. It handles
    connection management, data loading, and basic validation.
    
    Attributes:
        config: DataSourceConfig instance defining the source parameters
        conn: Active DuckDB connection instance
        
    Example:
        config = DataSourceConfig(source_type="csv", ...)
        source = AuditDataSource(config)
        data = source.load_table("customers")
    """
```

### Method and Function Documentation
- Use Google-style docstrings consistently
- Document all parameters, return values, and exceptions
- Include usage examples for public methods

```python
def load_table(self, table_name: str, sample_size: Optional[int] = None) -> pd.DataFrame:
    """
    Load table data from the configured source.
    
    Args:
        table_name: Name of the table to load as defined in configuration
        sample_size: Optional limit on number of rows to load for testing
        
    Returns:
        DataFrame containing the loaded table data
        
    Raises:
        ConnectionError: If unable to connect to the data source
        ValueError: If table_name is not found in configuration
        
    Example:
        df = source.load_table("customers", sample_size=1000)
    """
    pass
```

## Object-Oriented Programming Standards

### Class Design Principles
- Follow single responsibility principle - each class should have one clear purpose
- Use composition over inheritance when appropriate
- Apply appropriate design patterns (Factory, Observer, Strategy, etc.) when they improve code structure
- Make attributes private by default, expose through properties when needed
- Use `@property` for computed attributes and controlled access

```python
class DataValidator:
    """Validates data quality according to configured rules."""
    
    def __init__(self, validation_rules: Dict[str, callable]) -> None:
        self._rules = validation_rules
        self._results: List[ValidationResult] = []
    
    @property
    def results(self) -> List[ValidationResult]:
        """Get read-only access to validation results."""
        return self._results.copy()
    
    def add_rule(self, name: str, rule_func: callable) -> None:
        """Add a new validation rule to the validator."""
        self._rules[name] = rule_func
```

### Design Patterns Usage
- **Factory Pattern**: For creating different data source connectors
- **Strategy Pattern**: For different validation algorithms
- **Observer Pattern**: For audit progress monitoring
- **Builder Pattern**: For complex configuration objects
- **Singleton Pattern**: For shared resources like loggers (use sparingly)

## Logging System
- Never use print statements for logging or debugging

- Use Python's built-in `logging` module
- Configure loggers with appropriate levels: DEBUG, INFO, WARNING, ERROR, CRITICAL
- Include timestamps, log levels, class-method or function and module names in log format
- Support both console output and file logging with datetime in filename
- Use appropriate log levels for different types of messages
- Configure file rotation to prevent log files from growing too large

```python
import logging
from datetime import datetime
from pathlib import Path

def setup_logging(log_level: str = "INFO", log_dir: str = "logs") -> logging.Logger:
    """
    Configure logging with both console and file output.
    
    Args:
        log_level: Logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
        log_dir: Directory to store log files
        
    Returns:
        Configured logger instance
    """
    logger = logging.getLogger(__name__)
    logger.setLevel(getattr(logging, log_level.upper()))
    
    # Prevent duplicate handlers if function is called multiple times
    if logger.hasHandlers():
        logger.handlers.clear()
    
    # Create log directory if it doesn't exist
    Path(log_dir).mkdir(exist_ok=True)
    
    # Create formatter with detailed information
    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(funcName)s:%(lineno)d - %(levelname)s - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    
    # Console handler
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    
    # File handler with datetime in filename
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    log_filename = f"{log_dir}/app_{timestamp}.log"
    file_handler = logging.FileHandler(log_filename, encoding='utf-8')
    file_handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    
    logger.info(f"Logging configured - Console: {console_handler.level}, File: {log_filename}")
    return logger

# Usage example
logger = setup_logging(log_level="DEBUG", log_dir="logs")
logger.info("AuditDataSource initialized successfully.")
logger.debug("Loading configuration from config.json")
logger.warning("Configuration file not found, using defaults")
```

### Rotating File Handler Example
For production applications that run continuously, use `RotatingFileHandler`:

```python
import logging
from logging.handlers import RotatingFileHandler
from datetime import datetime
from pathlib import Path

def setup_production_logging(log_level: str = "INFO", log_dir: str = "logs") -> logging.Logger:
    """Configure production logging with file rotation."""
    logger = logging.getLogger(__name__)
    logger.setLevel(getattr(logging, log_level.upper()))
    
    if logger.hasHandlers():
        logger.handlers.clear()
    
    Path(log_dir).mkdir(exist_ok=True)
    
    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(funcName)s:%(lineno)d - %(levelname)s - %(message)s'
    )
    
    # Console handler
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    
    # Rotating file handler (5MB max, keep 5 backup files)
    timestamp = datetime.now().strftime("%Y%m%d")
    log_filename = f"{log_dir}/app_{timestamp}.log"
    file_handler = RotatingFileHandler(
        log_filename, 
        maxBytes=5*1024*1024,  # 5MB
        backupCount=5,
        encoding='utf-8'
    )
    file_handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    
    return logger
```

## Error Handling and Validation

- Use specific exception types, not generic Exception
- Create custom exceptions for domain-specific errors
- Include meaningful error messages with context
- Use `try-except-finally` blocks appropriately
- Log exceptions with sufficient context for debugging
- Follow established logging configuration for error reporting

```python
import logging
from pathlib import Path
import pandas as pd

logger = logging.getLogger(__name__)

class DataLoadingError(Exception):
    """Raised when data loading operations fail."""
    pass

class DataValidator:
    """Example class demonstrating proper error handling and logging."""
    
    def __init__(self, config_path: Path) -> None:
        """Initialize validator with configuration."""
        self.config_path = config_path
        logger.info(f"DataValidator initialized with config: {config_path}")
    
    def load_csv_file(self, file_path: Path) -> pd.DataFrame:
        """
        Load CSV file with comprehensive error handling.
        
        Args:
            file_path: Path to the CSV file
            
        Returns:
            DataFrame containing the loaded data
            
        Raises:
            DataLoadingError: When file loading fails
        """
        logger.info(f"Attempting to load CSV file: {file_path}")
        
        try:
            if not file_path.exists():
                error_msg = f"CSV file not found: {file_path}"
                logger.error(error_msg)
                raise FileNotFoundError(error_msg)
            
            logger.debug(f"File exists, reading CSV: {file_path}")
            df = pd.read_csv(file_path, encoding=self._detect_encoding(file_path))
            logger.info(f"Successfully loaded {len(df)} rows from {file_path}")
            return df
        
        except UnicodeDecodeError as e:
            error_msg = f"Encoding issue with {file_path}: {e}"
            logger.error(error_msg, exc_info=True)
            raise DataLoadingError(error_msg) from e
        except pd.errors.EmptyDataError as e:
            error_msg = f"CSV file is empty: {file_path}"
            logger.warning(error_msg)
            raise DataLoadingError(error_msg) from e
        except Exception as e:
            error_msg = f"Unexpected error loading {file_path}: {e}"
            logger.critical(error_msg, exc_info=True)
            raise DataLoadingError(error_msg) from e
    
    def _detect_encoding(self, file_path: Path) -> str:
        """Detect file encoding, defaulting to utf-8."""
        try:
            import chardet
            with open(file_path, 'rb') as f:
                result = chardet.detect(f.read(10000))
                encoding = result.get('encoding', 'utf-8')
                logger.debug(f"Detected encoding for {file_path}: {encoding}")
                return encoding
        except ImportError:
            logger.warning("chardet not available, using utf-8 encoding")
            return 'utf-8'
        except Exception as e:
            logger.warning(f"Encoding detection failed for {file_path}: {e}, using utf-8")
            return 'utf-8'
```

## Testing Standards with pytest

- Write comprehensive test suites using pytest framework
- Use descriptive test function names that explain the scenario
- Follow AAA pattern: Arrange, Act, Assert
- Use pytest fixtures for reusable test data and setup
- Include both positive and negative test cases
- Test edge cases and error conditions
- Aim for high test coverage but focus on critical paths

```python
import pytest
from pathlib import Path
from unittest.mock import Mock, patch

class TestAuditDataSource:
    """Test suite for AuditDataSource class."""
    
    @pytest.fixture
    def sample_config(self) -> DataSourceConfig:
        """Provide sample configuration for testing."""
        return DataSourceConfig(
            source_type="csv",
            tables={"test": TableConfig(name="test", query="SELECT * FROM 'test.csv'")},
            audit_scope={"objective": "Unit testing"}
        )
    
    @pytest.fixture
    def mock_data_source(self, sample_config: DataSourceConfig) -> AuditDataSource:
        """Create AuditDataSource instance for testing."""
        return AuditDataSource(sample_config)
    
    def test_load_table_success(self, mock_data_source: AuditDataSource) -> None:
        """Test successful table loading returns DataFrame."""
        # Arrange
        expected_columns = ["id", "name", "email"]
        
        # Act
        with patch('pandas.read_csv') as mock_read:
            mock_read.return_value = pd.DataFrame(columns=expected_columns)
            result = mock_data_source.load_table("test")
        
        # Assert
        assert isinstance(result, pd.DataFrame)
        assert list(result.columns) == expected_columns
    
    def test_load_table_invalid_name_raises_error(self, mock_data_source: AuditDataSource) -> None:
        """Test loading non-existent table raises appropriate error."""
        with pytest.raises(ValueError, match="Table 'nonexistent' not found"):
            mock_data_source.load_table("nonexistent")
```

## Dependencies and Imports

- Pin specific versions in requirements.txt
- Group imports logically and separate with blank lines
- Use relative imports for local modules within packages
- Avoid wildcard imports (`from module import *`)
- Import only what you need to keep namespace clean

```python
# Standard library imports
import json
import logging
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Union

# Third-party imports
import pandas as pd
import pytest
from pydantic import BaseModel, Field

# Local imports
from ..config import DataSourceConfig
from .validators import DataValidator

# Configure logging at module level
logger = logging.getLogger(__name__)
```

## Performance and Best Practices

- Use list comprehensions and generator expressions when appropriate
- Prefer built-in functions over manual loops for common operations
- Use `pathlib.Path` instead of `os.path` for file operations
- Implement `__str__` and `__repr__` methods for custom classes
- Use context managers for resource management
- Consider memory usage for large datasets
- Profile code when performance is critical

## Code Organization

- Organize code into logical modules and packages
- Keep modules focused and cohesive
- Use `__init__.py` files to control package imports
- Place tests in parallel directory structure (`tests/` mirroring `src/`)
- Separate configuration, utilities, and main application logic
- Use meaningful package and module names

## Validation Commands

- Format code: `black .`
- Check style: `flake8 .`
- Type checking: `mypy .`
- Run tests: `pytest tests/`
- Coverage report: `pytest --cov=src tests/`